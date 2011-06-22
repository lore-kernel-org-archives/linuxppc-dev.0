Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B2FEB80B8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 21:42:26 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
Date: Wed, 22 Jun 2011 11:40:28 +0000
Message-ID: <4E01D4AB.3010505@freescale.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<4DF7BE43.1010407@freescale.com>	<4DF7BF84.8030000@freescale.com>
	<BANLkTikcn7ghNF7YW7LO+=Qs_4A=RHxJSQ@mail.gmail.com>
In-Reply-To: <BANLkTikcn7ghNF7YW7LO+=Qs_4A=RHxJSQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas De Schampheleire wrote:
> I think I can make it more reliable by dummy reading the pages*after*
> I disabled interrupts on that processor, immediately before jumping to
> the boot code. Is that correct?

That sounds logical to me.

BTW, since you're already doing something non-standard with your module, wh=
y=20
don't you just make settlbcam exported?

--=20
Timur Tabi
Linux kernel developer at Freescale=
