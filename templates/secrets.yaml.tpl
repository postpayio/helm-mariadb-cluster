{{- range $name, $value := .Values.secret }}
---
apiVersion: v1
kind: Secret
{{ include "resourceValues" (list $name $value) }}
{{- end }}