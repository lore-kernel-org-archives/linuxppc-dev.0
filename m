Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D8706B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 04:13:24 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1477377rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 11:13:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4901A8.5010402@mlbassoc.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 29 Jun 2009 13:13:03 -0500
Message-ID: <97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	=?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gary

> Did you try 'root=ttyCPM0,9600'?

Gave that a shot just now, doesn't seem to have changed anything other
than that it now says "VFS: Cannot open root device ttyCMP0,9600" or
unknown-block(2,0)." But thanks for the suggestion though.

What exactly was this supposed to do? I thought that the "root=" boot
argument did not play a role in console output of the boot
information.
