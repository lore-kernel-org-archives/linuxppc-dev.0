Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DAA4DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 19:33:51 +1000 (EST)
Message-ID: <02f201c89edb$cb666150$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: "Ulf Samuelsson" <ulf.samuelsson@atmel.com>, <linuxppc-dev@ozlabs.org>,
	"Buildroot Mailinglist, " <buildroot@uclibc.org>
References: <014701c89bda$09380060$ad289e86@LPSC0173W><fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
	<01e801c89e49$6d0e6400$ad289e86@LPSC0173W>
	<000b01c89eb5$2af81630$070514ac@atmel.com>
Subject: Re: [Buildroot] zImage.embedded
Date: Tue, 15 Apr 2008 11:33:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think you need to figure out how to build u-boot for your board
> outside buildroot, before you try to build it inside buildroot.

Working on it...

While I do that, I have a side question:
is it possible to boot off a first kernel on a local partition, but tell it 
to tftp boot off another kernel instead ?

The rational is that I have a working system on a card in my embedded 
system, but if possible I'd like to have it boot off the latest version 
available on the network.

And if not available, simple boot using fallback parameters.

Makes sense ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
