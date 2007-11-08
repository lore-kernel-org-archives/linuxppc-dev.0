Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 3011BDDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 07:51:11 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so262841nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Nov 2007 12:51:10 -0800 (PST)
Message-ID: <9e4733910711081251w392b4a84m8e81d902305bf395@mail.gmail.com>
Date: Thu, 8 Nov 2007 15:51:09 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <473375E6.5080503@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>
	<473375E6.5080503@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
> Jon Smirl wrote:
> > No one has answered this yet. It makes no sense at all to mix use of
> > the vendor prefix on some compatible entries and not on others. The
> > syntax of compatible entries needs to be consistent.
>
> Right, the vendor prefix should always be used.  Not all of the existing
> trees are perfect, however, so sometimes the code needs to stay
> compatible, especially when the device tree is difficult to change.

A bunch of patches are going to have to go into the kernel. Code
expecting tree attributes without vendor prefixes is all over the
kernel. All of the dts file need to be patched up, etc.

As far as I know the only dts using vendor prefixes in the compatible
attributes is 5200lite one for the gpt entries. Everything else will
need to be changed.


>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
