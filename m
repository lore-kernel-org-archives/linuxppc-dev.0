Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE017.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5E1FB6F76
	for <linuxppc-dev@ozlabs.org>; Mon, 30 May 2011 00:54:03 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
Date: Sun, 29 May 2011 14:53:57 +0000
Message-ID: <BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
In-Reply-To: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
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

On Fri, May 27, 2011 at 8:25 AM, Thomas De Schampheleire
<patrickdepinguin+linuxppc@gmail.com> wrote:

> Although I realize that what I need to achieve is unconventional, what
> is the correct way of mapping a certain address range into memory, and
> be able to execute from it?

Have you tried looking at the actual TLB entry for this page to see if
it's correct?  Also, you might need to do some kind of instruction
cache flushing before you jump to that page.

--=20
Timur Tabi
Linux kernel developer at Freescale=
