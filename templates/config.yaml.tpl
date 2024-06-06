{{- range $name, $value := .Values.config }}
---
apiVersion: v1
kind: ConfigMap
{{ include "resourceValues" (list $name $value) }}
{{- end }}