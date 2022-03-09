# Example of Using regex to Edit ARM Template Files

Rough notes (very!)

----

## Replace Process for JSON Files - YAML Files

### Pass 1 (Normal)

Older NSG parameter files may not be using "destinationPortRanges".

```plaintext
Find: "destinationPortRange": -------- destinationPortRange:

Replace: "destinationPortRanges": -------- destinationPortRanges:
```

### Pass 2 (regex)

Values (for "destinationPortRanges") that are standalone e.g. 445 need to be enclosed within "" --> "445"

```plaintext
Find: (?<="destinationPortRanges":\s)([^"].*)(?=,) --------- (?<=destinationPortRanges:\s)([^"].*) ---- YAML

Replace: "$1"
```

### Pass 3

Values now need to be enclosed within [] (square brackets) e.g. "49152-65535" --> ["49152-65535"]

```plaintext
Find: (?<="destinationPortRanges":\s)(".*")(?=,) -------- (?<=destinationPortRanges:\s)(".*") ---- YAML

Replace: [$1]
```

### Pass 4

Any wildcard values e.g. ["*"] will not be parsed (due to the union statement) so they need to be changed to ["1-65535"]

```plaintext
Find: "destinationPortRanges": ["*"], -------- destinationPortRanges: ["*"]

Replace: "destinationPortRanges": ["1-65535"], ---------- destinationPortRanges: ["1-65535"]
```

----

## Acknowledgements

Useful site: <https://regex101.com/>
