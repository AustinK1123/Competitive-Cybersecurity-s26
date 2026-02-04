# Encryption (RSA) write-up

Brandon Walker
3 Feb 2026

Modern encryption can generally be described as the process of using a mathmatical algorithm to scramble a plain text message so that only authorized users can read it, through the process of decryption. This generally relies on the use of large prime numbers, or some sort of "key" system. 

## ECB encryption

This method of encryption encodes blocks using the same key, and so repeated parts of the encrypted file will have the same output, which results in an image where you can still see general shape and structure.

## CBC encryption

This method of encryption works similarly to ECB, but uses part of the from the previous block to feed into the current block, making it so repeated sections wont have the same output.

## OFB encryption

This method of encryption takes a random "initialization vector" as a starting value and encrypts it, and then saves that as the "first block" and then encrypts that to create the next block, and does this until it has enough blocks for the whole message, or image in this case. It then uses the XOR operation to combine this random stream of data with your message, thus creating unique changes throughout the document

## RSA encryption

This method of encryption functions akin to infinite padlocks that all take the same single key. The owner keeps the key, and hands out padlocks, anyone can lock a message, but only the one with the key can open them. It works on the idea that it is very easy to multiply two large prime numbers together, but very difficult to factor back down that result. If the two primes are p and q, their product is n, the public key is (n, e) where e is a large exponent, almost always 65,537 in modern systems. The private key is (n, d) where d is a massive number calculated using complex formulas and the original primes.

The primes are then only needed for a person trying to break in, though they are also used to allow special methods to speed up decryption.

## RSA challenge

The challenge is to break this RSA encryption that is only feasible because too small of primes were used. The known parts are below, with c being the encrypted message, or "cipher".

n = 1079
e = 43
c = 996 894 379 631 894 82 379 852 631 677 677 194 893

First you need to get p and q, for this challenge there is only two primes in the prime factorization
n=p∗q
1079=p∗q
1079=83∗13
p=83,q=13

now you need to use them and the known e to calculate d, the last element of the private key
d∗e=1 mod (p−1)(q−1)
d∗43=1 mod (83−1)(13−1)
d=43^−1 mod 984
d=595

The calculated values are -
p = 83
q = 13
d = 595

Now you use the below process to calculate each character from the cipher. 
m=c^d(modn)
m=996^595 mod 1079
m=83

m = SKY-KRYG-5530
