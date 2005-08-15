Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id E6FCF67EB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 03:16:40 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 15 Aug 2005 10:16:37 -0700
To: Andrey Volkov <avolkov@varma-el.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050815171637.GA20943@xyzzy.farnsworth.org>
References: <43006FD4.6060801@varma-el.com> <43009A8D.1040704@246tNt.com>
	<4300AF41.9000807@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4300AF41.9000807@varma-el.com>
Subject: Re: [00/02] MPC5200 Bestcomm platform driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 15, 2005 at 03:05:37PM +0000, Andrey Volkov wrote:
> Sylvain Munaut wrote:
> > Obviously I haven't yet had the time to review all the code but the
> > glance I had looked good ! I'll review it deeper and test it and come
> > back to you asap.
> As you could see it was only first step (I hope at not so long way :)):
> bring Dale's code to the current kernel, and make point from which
> everyone could start dance.

Andrey, thanks for keeping this alive.

I agree with Sylvain's other comments.

The main thing I would like to see happen to this driver (other
than getting it in mainline :-) is an attempt to replace the
ugly phy code with calls to the new phy abstraction layer.
On the other hand, I'm glad to see progress on any front.

-Dale
