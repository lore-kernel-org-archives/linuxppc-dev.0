Message-ID: <009501c284fb$c2fb44e0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Atmel Flash
Date: Tue, 5 Nov 2002 19:47:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to modify the board specific routine "flash.c" to perform erase,
write and other procedure on my custom board (that use an mpc8260 and is
derived from est8260).
We are using an ATMEL AT49BV1614-90TI but unfortunately we are not able to
read the product IDs.
We have tested the same code with a Fujitsu MBM29LV160B (which should be
compatible) and it is working.

I have read the data sheet carefully but I did not see any evidence?

Anybody knows if there is some trick to apply?

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
