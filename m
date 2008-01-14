Return-Path: <Jogi95@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	by ozlabs.org (Postfix) with ESMTP id 3D8FDDDED6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 10:10:49 +1100 (EST)
Date: Tue, 15 Jan 2008 00:10:46 +0100
Message-Id: <533967497@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: enno.luebbers@upb.de
Subject: Re: Re: Linux for ml310
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Enno

I believe, like Grant Likely said, I had the wrong Version of the Kernel, =
so the generated BSP for the ml310 didn't cooperate with it.
Anyway, I'm now using the 2.6 kernel, and with the help of Grant Likely, m=
y Kernel boots till he can't find the rootFS (because there isn't yet one)=
.
I prefere the 2.6 because my main "mssion" is to make an realtime Linux wi=
th rtai for the ml310 and I believe it will be easier for the 2.6 beacause=
 there are more people who spent time with it.
The Problem I have is that I need a Network Interface and because I read, =
that the PCI Bridge doesn't work with the kernel I use, I have none, so I'=
ll probably change to the XUP.
Greetings
Joachim

PS: I believe I made the correct configuration for the BSP, I also setted =
the clk-freq and the peripherals.

--------------------------------------------------------------------------=
-------------------------------------------
>Hi Joachim,
>
>I haven't tried the XUP or the ML310 yet, but I just managed to get
>Linux 2.4.26 from Bitkeeper running on a ML403 board (a Virtex-4FX12).
>However, I'm seriously considering moving to the 2.6 kernel, for
>various reasons.
>
>Your problems seem to be related to the BSP configuration. Have you
>set the corerct options in the Software Platform Settings of the EDK=3F
>In particular, you need to set the clock frequency and the attached
>peripherals in the "OS and Libraries" section.
>
>Regards
>- Enno
>
>--=20
>Dipl.-Ing. Enno Luebbers
>Computer Science Department
>University of Paderborn
>
>Warburger Str. 100
>33098 Paderborn
>
>http://wwwcs.upb.de/cs/ag-platzner
>phone: 05251 / 60-5397
>fax: 05251 / 60-5377


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
