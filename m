Return-Path: <monodhs@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 52183DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:47:23 +1000 (EST)
Message-ID: <4652219D.6050308@gmx.de>
Date: Tue, 22 May 2007 00:47:57 +0200
From: =?UTF-8?B?Q2hyaXN0aWFuIELDtmhtZQ==?= <monodhs@gmx.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
References: <4650E27B.3020401@gmx.de>	
	<1179712614.32247.597.camel@localhost.localdomain>	
	<4651FC48.8000002@gmx.de>
	<1179785502.32247.748.camel@localhost.localdomain>
In-Reply-To: <1179785502.32247.748.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> Or it could be the DMA channel going dead though I fail to see why it
> would just start doing that now.

...

> Not sure where to start :-) I'll first see if I can reproduce.

It's not that I am not interested nor completely new to this, it's just that
I am currently a little short on time for things like these.  The last time
I checked, the Linux people have just started to make use of DMA maps, a
concept that other OS/architecture combos employed for years already.  Is
that what is used in the TiBooks to allocate DMA channels ?


Cheers,
Christian
