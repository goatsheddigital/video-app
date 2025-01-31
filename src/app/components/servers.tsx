import { getServers } from "dns";

export default async function Servers(){
    const servers = await getServers();
    // create a clickable link to each server
    return (
        <div>
            {servers.map((server) => (
                <div key={server} className="my-2">
                    <a href={`/server/${server}`}>{server}</a>
                    <div className="text-sm text-gray-500">{server}</div>
                    <image href={server} name={server} width={40} className="w-1 h-1 rounded-full" />
                    <div className="text-xs text-gray-400">{server}</div>
                </div>
            ))}
        </div>
    );
}