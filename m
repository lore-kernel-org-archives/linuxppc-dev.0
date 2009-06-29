Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 97D3BB7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 06:31:14 +1000 (EST)
Message-ID: <4A49249C.5080101@freescale.com>
Date: Mon, 29 Jun 2009 15:31:24 -0500
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
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
In-Reply-To: <97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
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
> Hi Scott,
> 
>> s/root=/console=/
> I'm not quite sure what you mean by this.

Change "root=" to "console=".

-Scott
