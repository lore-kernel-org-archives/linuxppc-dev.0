Message-Id: <m11tCut-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 1 Dec 1999 17:47:43 +0100 (CET)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: alois_fertl@muenchen.europe.mcd.mot.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com> (message from
	Alois Fertl on Wed, 01 Dec 1999 17:11:48 +0100)
Subject: Re: PPC Compiler Problem?
References: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Alois" == Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com> writes:

Alois> Given the following lines of C, I'd expect that the 4th argument
Alois> is placed into register 6 and 7. As the assembler listing tells,
Alois> register 6 is omitted and the argument goes into r7/r8.

I indeed checked the "PowerPC Processor ABI Supplement" dated September 95
(SVR4 PowerPC ABI) and on 3-18 I see :

For PowerPC, up to eight words are passed in general purpose registers, loaded
sequentially into general purpose registers r3 through r10.

It is clear that this breaks the SVR4 ABI... So you can probably open a bug
report...

The PPC EABI does not differ on that aspect... If someone can point me
to the last spec if I'm wrong...


-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
