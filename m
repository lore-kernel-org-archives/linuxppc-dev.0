Return-Path: <Agostino.Sette@siemens.com>
Received: from MILVB94A.icn.siemens.it (milvb94a.icn.siemens.it
	[83.103.117.135]) by ozlabs.org (Postfix) with ESMTP id 6756368719
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Nov 2005 22:27:32 +1100 (EST)
Message-ID: <69DF49BE936F4441980EC1D59F0ADC2F010ADBDD@aqlby02a.siemens.it>
From: Sette Agostino <Agostino.Sette@siemens.com>
To: wd@denx.de
Date: Mon, 14 Nov 2005 12:26:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPCBoot 2.0.0 Errors 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Wolfgang,

Now I have the U-Boot for MPC859, but I am not sure this line is =
correct

U-Boot 1.1.3 (Nov 11 2005 - 16:38:24)

CPU:   MPC859TxxZPnnA at 133 MHz: 16 kB I-Cache 8 kB D-Cache FEC =
present


As far as I know, the I-Cache and the D-Cache of the MPC859 is 4 kB, as
defined in the MPC866UM Appendix F.

Here is the chapter which describe the cache

F.3 Cache Control Registers
The MPC859T bit fields and commands of the cache control and status
registers (IC_CST
and DC_CST) are implemented the same as for the MPC866P. However, the =
bit
fields of
the cache address registers (IC_ADR and DC_ADR) and the cache data port
registers
(IC_DAT and DC_DAT) must be used for the 4-Kbyte instruction and data
caches. See
Chapter 7, "Instruction and Data Caches."

We think that the MPC859 probably has phisically the same cache size as =
the
MPC866, but only 4 kB must be used.
Anyway, my question is, must I worry about the data printed on the =
screen or
can I leave as they are?
I mean, are these information used in other part of the U-Boot or the
Kernel?

Thanks in advance.

Best Regards
Agostino Sette



-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=20
Sent: marted=EC 8 novembre 2005 14.38
To: Sette Agostino
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPCBoot 2.0.0 Errors=20

In message =
<69DF49BE936F4441980EC1D59F0ADC2F0108C29F@aqlby02a.siemens.it>
you wrote:
>=20
> As I told you, I tried to produce the U-boot, but I am nont confident =
on
the
> version (1.0.0).

No, indeed. This is ancient stuff. Use top of tree from the GIT  repo
(or CVS), or download the latest snapshot from our FTP server.

> Could you suggest me the latest stale version I must get?

May I suggest that you start reading the manual? See
http://www.denx.de/wiki/DULG/Manual

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I will not say that women have no character;  rather, they have a new
one every day.                                               -- Heine
