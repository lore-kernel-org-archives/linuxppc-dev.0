Message-ID: <005b01bff72a$dc426890$a66d34c0@oleane.com>
From: "Lionel TAILLURAT" <Lionel.TAILLURAT@ecrin.com>
To: "ppc_mailing_list" <linuxppc-embedded@lists.linuxppc.org>
Subject: -= MVME 2300 boot args=-
Date: Wed, 26 Jul 2000 19:56:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a full working kernel with VME bus support (thx Gabriel for your
patch and your help).

The problem now is that I can't have the boot args working !

During the configuration of the kernel, I write "root=/dev/sda2
console=ttyS0" in the "initial kernel command string" , and only
"console=ttyS0" is shown at boot prompt and the kernel don't see my
haddrive!

If I use the command (in PPCBUG):
GEVEDIT bootargs
bootargs=root=/dev/sda2 console=ttyS0

result : same as above !

Whats wrong ?

I always need to write by hand "root=/dev/sda2" !

Please help me !

Thx in advance.
-------------------------------------------------------
Lionel TAILLURAT
TECHNICAL SERVICE

ECRIN AUTOMATISMES -industrial computer's-
Rue du pré-de-l'Horme
B.P 15
38921 CROLLES CEDEX
FRANCE
Tel :(33) 4 76 92 20 01
Fax :(33) 4 76 08 03 18
Email: Lionel.TAILLURAT@ecrin.com
---------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
