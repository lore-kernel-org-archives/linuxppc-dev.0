Message-ID: <003701bfe3b2$65435aa0$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA timing help.
Date: Sun, 2 Jul 2000 08:16:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

After sending 2 messages at this mailing list, I checked and read all messages related PCMCIA on list-archive.

Then I found my "Machine check ..." problem is timing related.

So, I changed the variable clocks from 0 to 47 (under PCMCIA_BMT_LIMIT) in function m8xx_get_speed (line 655) of m8xx_pcmcia.c of pcmcia-cs-3.1.10.

But I can't solve the problem.

There are "Machine check ..." everytime. sigh...

Even if BMT is disabled, no success.

My board is RPX Lite 850 SR, 50MHz cpu clock and bus freq. (bi_busfreq tells 48 though) and PCMCIA cards are Xircom CE3-10BT and 3Com Megahertz 3CCFE574BT.

Please help me anyone.

Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
