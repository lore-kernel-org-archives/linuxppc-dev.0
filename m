Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Jul 2007 06:51:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: ThomasB <psyphi@gmail.com>
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
Message-ID: <20070710135102.GA22993@mag.az.mvista.com>
References: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
	<20070710132207.12018.qmail@farnsworth.org>
	<13b81f0c0707100641i56e08bd3n7c7911782a81628a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13b81f0c0707100641i56e08bd3n7c7911782a81628a@mail.gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 03:41:25PM +0200, ThomasB wrote:
> >Isn't the ethernet the same on the 64260, 64360, 64460?
> >
> >There's definitely a driver for 6436x and above..
> 
> I just try it, it doesn't work, I receive without end the message:
> mv643xx PHY read timeout, port 0
> 
> >I believe that Steve Hill <sjhill@realitydiluted.com> has patched
> >the mv643xx_eth driver to work with the 64260 and plans to submit
> >the patches.
> That's means the patch isn't yet ready?

It probably means you don't something set up for whatever PHY you're
using.

> I will try to contact him.

A good idea.

> It's nevertheless odd, I read about a file named gt64260_eth.c during my
> search on the internet.But I wasn't able to find it :(.

There was one for 2.4 that was in the ppc devel tree but it never went
mainline.  Hopefully, Steve can help you from here.

Mark
