Message-ID: <001701c2c33f$298715f0$5e207aa1@fish>
From: "Jason Park" <jason@amadeus.kist.re.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How do you change the program counter (PC)
Date: Fri, 24 Jan 2003 09:25:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi, I've got another simple question... but couldn't find an answer in the
archives.

I just compiled the ppcboot for the ep8260.. and placed the .bin version at
location 0xffc00000.

i have the planetcore bootloader that came with the ep8260 at location
0xfff00000.

now, i want to test and check whether the ppcboot loader will work properly
before i overwrite the planetcore bootloader code.  how can i change the PC
(which states 0xfff0 0100 when i type "info" at the BDI prompt)...

also, whats the main difference between the 3 files created by ppcboot.
(ELF, BIN, SREC)  besides size..  is there an advantage/disadvantage using
one over the other?  is it dependant on the debugger?

thanks,
Jason P.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
