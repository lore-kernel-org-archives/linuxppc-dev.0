Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 0EEDFDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 02:41:52 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so259610anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 09:41:51 -0700 (PDT)
Message-ID: <fa686aa40709030941x1dee3898ud881497b534cc6aa@mail.gmail.com>
Date: Mon, 3 Sep 2007 10:41:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC PATCH v0.2] net driver: mpc52xx fec
In-Reply-To: <9e4733910709030909j50710faaw96c95cb369a810b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<9e4733910709030909j50710faaw96c95cb369a810b3@mail.gmail.com>
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

On 9/3/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/3/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 9/2/07, Domen Puncer <domen@coderock.org> wrote:
> > > Hi!
> > >
> > > new in this version:
> > > - fixed stuff that was commented on.
> > > - added 7-wire support (compile at least, if someone has the hardware,
> > >         please test!)
> > > - ethtool support
> >
> > Thanks for this work Domen, comments below...
> >
> > This is a large patch, and it should be broken up into logical
> > changes.  ie. split into dts changes, bestcomm changes, fec driver and
> > mdio driver.  Easier to review that way.  The bestcomm and dts changes
> > don't need to go to the netdev list.
>
> A similar patch that is already broken up is available for Efika.
> http://dev.gentoo.org/~nixnut/efika/efika-patches-2.6.22.tar.bz2

No.  That series is Sylvain's full patchset including the old FEC
driver.  Domen's patch is a reworked FEC driver, and it only replaces
patch 0008 from that series.  However, this patch should be split up
further because it makes changes to both the device tree and the
bestcomm code.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
