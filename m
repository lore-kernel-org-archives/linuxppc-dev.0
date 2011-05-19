Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE007.bigfish.com (ch1ehsobe002.messaging.microsoft.com
	[216.32.181.182]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5580B718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:54:12 +1000 (EST)
Message-ID: <4DD53D1B.4060600@freescale.com>
Date: Thu, 19 May 2011 10:54:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
References: <1305813272-31826-1-git-send-email-timur@freescale.com>	<1305813272-31826-7-git-send-email-timur@freescale.com>	<20110519153358.5876f310@lxorguk.ukuu.org.uk>	<4DD533DE.1020705@freescale.com>
	<20110519165039.7fd8ec34@lxorguk.ukuu.org.uk>
In-Reply-To: <20110519165039.7fd8ec34@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
>>> > > The kfifo API is probably faster and cleaner. Much of tty still uses
>>> > > CIRC_* because they predate the new APIs.
>> > 
>> > Ok, I'll change it.
> I flag that one up as a general comment - don't feel you need to change
> it if CIRC_* works in your case.

CIRC_* does work for me, so I'll keep it as-is.

>>> > > I guess the only other thing to consider is whether you want to implement
>>> > > a SYSRQ interface on your console ?
>> > 
>> > I don't think byte channels can support SYSRQ, but I'll look into it.

> What some drivers do in this case is nominate some obscure ctrl sequence
> to mean 'sysrq' unless doubled (eg ctrl-^ etc)

Ok, I can do that.

> Depends if the functionality is useful in your environment or not

It is, but I'd like to add it later so that I can make the 2.6.40 window (if it
isn't already too late).


-- 
Timur Tabi
Linux kernel developer at Freescale
