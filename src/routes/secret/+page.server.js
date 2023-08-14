import { getAllFiles } from 'get-all-files'

export const load = async (event) => {  
  const files = await getAllFiles(`log/`).toArray();
  return { data: files };
}
