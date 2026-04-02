part 1
what is the organization name?
he organization name is found within the "Subject" and "Issuer" fields of the X.509 certificate, typically denoted by the O= attribute.
Windoge Certificate Authority


part 2
extract
then run
osslsigncode

(generated from ai, couldnt figure out)
for f in flag_*.exe; do
    if osslsigncode verify -CAfile ca\(1\).crt "$f" 2>/dev/null | grep -q "Verified OK"; then
        echo "=== VALID SIGNATURE FOUND: $f ==="
        strings "$f" | grep -E "flag\{|CTF|flag_"
        ./"$f"   # run it (in a VM/sandbox!)
        break
    fi
done

will say when right file
