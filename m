Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id EB2AFDDE37
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 02:09:09 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2036338wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 09:09:08 -0700 (PDT)
Message-ID: <9e4733910709030909j50710faaw96c95cb369a810b3@mail.gmail.com>
Date: Mon, 3 Sep 2007 12:09:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH v0.2] net driver: mpc52xx fec
In-Reply-To: <fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
Cc: netdev@vger.kernel.org, Domen Puncer <domen@coderock.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/3/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 9/2/07, Domen Puncer <domen@coderock.org> wrote:
> > Hi!
> >
> > new in this version:
> > - fixed stuff that was commented on.
> > - added 7-wire support (compile at least, if someone has the hardware,
> >         please test!)
> > - ethtool support
>
> Thanks for this work Domen, comments below...
>
> This is a large patch, and it should be broken up into logical
> changes.  ie. split into dts changes, bestcomm changes, fec driver and
> mdio driver.  Easier to review that way.  The bestcomm and dts changes
> don't need to go to the netdev list.

A similar patch that is already broken up is available for Efika.
http://dev.gentoo.org/~nixnut/efika/efika-patches-2.6.22.tar.bz2

-- 
Jon Smirl
jonsmirl@gmail.com
