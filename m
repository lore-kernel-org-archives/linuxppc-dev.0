Return-Path: <marcelo.tosatti@cyclades.com>
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC4B72BF18
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 08:53:06 +1100 (EST)
Date: Wed, 12 Jan 2005 16:27:58 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <20050112182758.GA1185@logos.cnet>
References: <313680C9A886D511A06000204840E1CF0A6474B2@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6474B2@whq-msgusr-02.pit.comms.marconi.com>
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6 8xx kernel booting vs watchdog
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 02:41:18PM -0500, Povolotsky, Alexander wrote:
> Hi,
> 
> I wonder if someone could help me with answering couple of my questions:
> 
> How watchdog resetting is handled for PPC 
> in Linux 2.6 on the kernel level ?
> Does one need to add code for it or is it supported "off the shelf" ?

It is not supported off the shelf. 

We (Cyclades) have a timer to periodically touch the watchdog on boot, and afterwards
a watchdog driver which gets periodically written by a userspace daemon. 

I can send a patch if you wish.

> Is "early printk" supported for PPC on 2.6 ?
> If yes - how and where it could be enabled?

Not sure.
