const BASE_URL = "http://10.0.2.2:8080/v1";

export const LocalPlugin = async ({ project, client, $, directory, worktree }) => {
  const models = await fetchModels();
  console.log("LLama.cpp plugin initialized!")

  return {
    async config(config) {
      const local_provider = {
        name: "llama-server (local)",
        npm: "@ai-sdk/openai-compatible",
        options: {
          baseURL: BASE_URL
        },
        models: models
      };
      config.provider ??= {};
      config.provider["local"] = local_provider;
    },
  };
}

const fetchModels = async () => {
  const model_url = BASE_URL + "/models";
  const raw_response = await fetch(model_url);
  const parsed = await raw_response.json();
  const result = {};
  for (const model of parsed.data) {
    result[model.id] = {
      name: model.id,
    }
    const context_size = await determine_context_size(model);
    if (context_size) {
      result[model.id].limit = {
        context: context_size,
        output: context_size
      }
    }
  }
  return result;
}

const determine_context_size = async (model) => {
  const args = model.status.args;
  const ctxIndex = args.indexOf('--ctx-size');
  if (ctxIndex !== -1) { return Number(args[ctxIndex + 1]) } else { return undefined };
}
