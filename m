Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0EB2FDDEBF
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 06:00:56 +1000 (EST)
In-Reply-To: <E1HuW61-00049R-FI@jdl.com>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<E1HuGfE-0007zw-EH@jdl.com>
	<1180743742.19517.485.camel@localhost.localdomain>
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
	<E1HuW61-00049R-FI@jdl.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <27807251665003e059b2c39d2b700415@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts
	file.
Date: Sat, 2 Jun 2007 22:00:47 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That, and I often get tired of seeing the same mistakes
>> over and over again.  When I see a proposed tree that's
>> just too awful I don't really know where to start.
>
> That is a good point.
>
> I think there are several factors at work here.  First and
> foremost, I am not an expert in this area; it is new to me.
> I am not afraid to say that I really need the guidance of
> an expert here.

Feel free to ask for advice on IRC, on the list, or
elsewhere _before_ sending a patch.

> Second, perhaps there is lingering legacy
> crap in some of the early DTS files that should be systematically
> cleaned up.

Yes there is.  Maybe one day I'll get to it, I'm hoping
someone else will fix this though ;-)

> Many of them were written during a time when we
> were really first learning about the whole Device Tree.  While
> they may have been there on some, say, Apple boards, it's all
> new for the FSL embedded parts.

Many apple trees (pun intended) aren't all that great
either.

> Cloned mistakes then likely
> contributed to the problems and should be fixed.  Finally,
> perhaps our documentation on how some of the important fields
> should work or be derived is lacking and could be improved.

The official (and unofficial) Open Firmware docs are quite
good.  Perhaps we need a big huge fat sign in the DTS docs
pointing to them.

> Suggestions or patches down this line would likely be welcomed.
>
>> I also find the DTS source format a bit hard to read,
>> but maybe that's just me.
>
> I, at least, am open to suggestions that might improve it.

My biggest problem when reviewing patches (or whole trees)
in mail is the indenting.  Part of that I could fix myself
by setting my mail reader to eight spaces indent.  The bigger
problem is that trees are just not very readable in flat
text format (you really need to see the parent node together
with every of its child nodes).  There's no real way to fix
this I'm afraid.  In "real" OF, most properties are filled
in programmatibly, and you typically have one node per source
file.  This won't help for DTS files.  Maybe putting more
(good!) comments in DTS files would help though?


Segher
