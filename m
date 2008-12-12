Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 90A0CDDFA9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Dec 2008 01:39:06 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LB9AT-0004Uu-Uf
	for linuxppc-embedded@ozlabs.org; Fri, 12 Dec 2008 06:39:01 -0800
Message-ID: <20976787.post@talk.nabble.com>
Date: Fri, 12 Dec 2008 06:39:01 -0800 (PST)
From: "sarah.ddff" <sarah.ddff@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P + EDK 9.1 + Linux 2.4
In-Reply-To: <4941CB50.6060704@bucknell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <4941CB50.6060704@bucknell.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have linux 2.6 running on the xupv2p with uart and ethernet.
Also, I have linux 2.6 running with uart, sysace and ethernet.=20
You can find here: https://rm-rfroot.net/xupv2p/ useful instructions to por=
t
linux 2.4 to the xupv2p board.


Juliana Su wrote:
>=20
> Hi,
>=20
> I'm relatively new to the XUPV2P. Up until about a month ago, I had been=
=20
> working with an ML310. Anyway, I noticed the =E2=80=9CXUPV2P update to ke=
rnel=20
> 2.6 fails=E2=80=9D thread and saw that quite a few people have been succe=
ssful=20
> with the XUPV2P; I was hoping that those of you who have been successful=
=20
> with the XUPV2P could help me out.
>=20
> First some background...
>=20
> I am using EDK 9.1, EDK 10.1, the MontaVista Linux 2.4 kernel=20
> (linuxppc_2_4_devel), and a 256 MB DDR DIMM. I was able to get a basic=20
> system (XPS UART16550, DDR SDRAM - MPMC, XPS SYSACE, Linux 2.4) made in=
=20
> EDK 10.1 to work. However, I have not had any success getting a similar=
=20
> system (UART16550, DDR_SDRAM_32Mx64 - PLB DDR, OPB SYSACE, Linux 2.4)=20
> built in EDK 9.1 to work. The issue is that, when I turn on the board,=20
> nothing shows up in minicom. I checked the contents of the log_buf; it=20
> was filled with junk.
>=20
> My goal is a system with SysACE support, Ethernet, and the AC-97 audio=20
> CODEC that can mount a hard drive. It seems like it would be easier to=20
> create this system using EDK 9.1 than EDK 10.1. Right now, though, just=
=20
> getting a basic system to work using EDK 9.1 would be great.
>=20
> For those of you who have been successful with the XUPV2P, what=20
> configurations in the EDK 9.1 Base System Builder Wizard and what Linux=
=20
> kernel worked for you? Any suggestions as to why I might not be getting=
=20
> any output? Would it be possible for me to use Linux 2.6 or should I=20
> stick with Linux 2.4? (I feel like Linux 2.4 would be better, but I=20
> thought I would ask anyway.) Also, are there any known issues with EDK=20
> 9.1 and the XUPV2P? I vaguely remember reading about memory issues=20
> somewhere, but I can=E2=80=99t remember if they were related to EDK 9.1, =
EDK=20
> 10.1, or both.
>=20
> Let me know if I should provide any additional information. Thanks!
>=20
>=20
> -Juliana
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/XUPV2P-%2B-EDK-9.1-%2B-=
Linux-2.4-tp20969433p20976787.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
