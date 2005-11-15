Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <1132001719.5504.204.camel@gaston>
References: <1132001719.5504.204.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <269d7972781989e47cc114f8e2124b80@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Mon, 14 Nov 2005 23:10:08 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I've just done some basic testing of lmw/stmw, lwz/stw, lhx/sth,=20
lfs/stfs, and lfd/stfd misaligned across a doubleword boundary, and=20
everything looks good so far.   I'll check out the byte reversals and a=20=

few other forms tomorrow.

Cheers,
B

On Nov 14, 2005, at 2:55 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-11-14 at 13:53 -0600, Becky Bruce wrote:
> > Ben,
> >
> > I talked to Kumar about this a little bit (I had started a merge of
> > this file, but got distracted!) and he doesn't have any test cases.=A0=

> > I'll put something together and test this out on some of the 32-bit
> > systems I have here in my lab.=A0 It won't be complete, but it will =
be
> > something.......
>
> Thanks,
> Ben.
>
