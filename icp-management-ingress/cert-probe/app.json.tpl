{
	"server": {
		"port": {{ .Values.probe.port }},
		"pretty": true
	},
	"fileWatcher": {
		"periodSeconds": {{ .Values.probe.periodSeconds }},
		"fileCollections": [
			{
				"name": "tls-certs",
				"paths": [
					"/etc/router/certs/tls.crt",
					"/etc/router/certs/tls.key"
				],
				"reportWhen": [
					{{ .Values.probe.reportWhen | quote }}
				]
			}
		]
	}
}
