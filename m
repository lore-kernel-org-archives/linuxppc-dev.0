Message-Id: <m11tDzU-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 1 Dec 1999 18:56:32 +0100 (CET)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: gdt@linuxppc.org
CC: linuxppc-dev@lists.linuxppc.org, alois_fertl@muenchen.europe.mcd.mot.com
In-reply-to: <XFMail.991201105013.gdt@linuxppc.org> (message from Gary Thomas
	on Wed, 01 Dec 1999 10:50:13 -0700 (MST))
Subject: Re: PPC Compiler Problem?
References: <XFMail.991201105013.gdt@linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Gary" == Gary Thomas <gdt@linuxppc.org> writes:

Gary> On 01-Dec-99 VALETTE Eric wrote:
>> 
>>>>>>> "Alois" == Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com> writes:
>> 
Alois> Given the following lines of C, I'd expect that the 4th argument
Alois> is placed into register 6 and 7. As the assembler listing tells,
Alois> register 6 is omitted and the argument goes into r7/r8.
>> 
>> I indeed checked the "PowerPC Processor ABI Supplement" dated September 95
>> (SVR4 PowerPC ABI) and on 3-18 I see :
>> 
>> For PowerPC, up to eight words are passed in general purpose registers, loaded
>> sequentially into general purpose registers r3 through r10.
>> 
>> It is clear that this breaks the SVR4 ABI... So you can probably open a bug
>> report...
>> 

Gary> If you read carefully, on page 3-18 of the SYSV ABI report, for a long long
Gary> argument being placed in register 'gr':
Gary>   " if gr is even, set gr to gr+1.  Load the lower addressed word into gr and
Gary>     the higher addressed word into gr+1."

Gary> Thus, the implementation _is_ correct.  long long arguments always occupy
Gary> an odd/even pair of registers.


Where do you see long long in the example???

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
