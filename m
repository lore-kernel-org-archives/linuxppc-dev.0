Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 39F71B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 04:41:37 +1000 (EST)
Message-ID: <4A490AE4.7000509@freescale.com>
Date: Mon, 29 Jun 2009 13:41:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
In-Reply-To: <97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?RnJhbmsgU3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
> Hi Gary
> 
>> Did you try 'root=ttyCPM0,9600'?
> 
> Gave that a shot just now, doesn't seem to have changed anything other
> than that it now says "VFS: Cannot open root device ttyCMP0,9600" or
> unknown-block(2,0)." But thanks for the suggestion though.
> 
> What exactly was this supposed to do? I thought that the "root=" boot
> argument did not play a role in console output of the boot
> information.

s/root=/console=/

Alternatively, you can set /chosen/linux,stdout-path to poin to the 
serial node you want to use for the console.

-Scott
