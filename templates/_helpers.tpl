{{/*
This function will take all the key value pairs passed in and render it as yaml.
Use this after defining the type of resource.
*/}}
{{- define "resourceValues" -}}
{{- $name := index . 0 -}}
{{- $value := index . 1 -}}
{{- $mergedMetadata := dict "metadata" ( dict "name" $name ) }}
{{- if hasKey $value "metadata" }}
{{- $mergedMetadata := merge dict "metadata" (dict "name" $name) $value.metadata}}
{{- end }}
{{- $merged := merge $value $mergedMetadata }}
{{ toYaml $merged }}
{{- end -}}