Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 053BAB7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 06:24:21 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1499166rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 13:24:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A490AE4.7000509@freescale.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 29 Jun 2009 15:24:00 -0500
Message-ID: <97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
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

Hi Scott,

> s/root=/console=/
I'm not quite sure what you mean by this.

> Alternatively, you can set /chosen/linux,stdout-path to poin to the serial
> node you want to use for the console.
If you look at the bottom of ep88xc.dts that I attached with my
previous post, I added the following:
chosen {
		linux,stdout-path = "/soc@f0000000/cpm@9c0/serial@a80"; // MZ -
added this 'chosen' section
};

However it did not seem to help, unless I did this wrong... still no
console output.

Thanks,
Mikhail
