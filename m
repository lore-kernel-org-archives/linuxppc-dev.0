Message-Id: <m144Q7e-001SzYC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: MontaVista HardHat linux
To: frog@lgic.co.kr
Date: Fri, 8 Dec 2000 11:11:46 -0500 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <002b01c060de$d8de2fe0$6c879696@LocalHost> from "Kim, Jeong-Hwan" at Dec 08, 2000 03:19:33 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Is there anybody who have a boot code (ROM monitoring code) for downloading
> HardHat linux
> in EST SBC8260 board ?

> HardHat manual says that there is a Boot Program for SBC8260 named RMON.
> Is it a free software or commercial one?

> How can I download HardHat linux in EST SBC8260 board or custom board ?

The PPCBOOT project is working towards supporting the EST SBC8260
board, but it isn't there yet.  I have been using the VxWork bootrom,
with tweaks to Linux support the correct generation of an ELF file
and IMMR fixup to the expected Linux value.

See http://www.sourceforge.net/projects/ppcboot/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
