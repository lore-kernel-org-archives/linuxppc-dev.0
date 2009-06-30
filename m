Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 437CBB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 15:17:16 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1396967rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 22:17:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A492C1A.6020302@freescale.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
	<97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
	<4A492C1A.6020302@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Tue, 30 Jun 2009 11:11:35 -0500
Message-ID: <97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Check the clock-frequency of the CPM BRG node. =A0If u-boot isn't setting=
 the
> memory, it's probably not setting this either.

I set the CPM BRG "clock-frequency =3D <153609>" (value obtained from
u-boot's 'brginfo' command), set my CPU "clock-frequency =3D
<100000000>" (down from 130000000) to match what u-boot is using, and
used the "console=3DttyCPM0,9600n8" boot arg and I've finally got
console output! Thanks everyone!

I'll still try to figure out how to get u-boot to fill all this in.
