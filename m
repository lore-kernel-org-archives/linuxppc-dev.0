Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 70C43DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 09:41:56 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1093817rvf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Aug 2007 16:41:55 -0700 (PDT)
Message-ID: <fa686aa40708061641i345f2a40u1a8149f849d2074d@mail.gmail.com>
Date: Mon, 6 Aug 2007 17:41:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <20070806233630.95E233B0080@mail28-fra.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200708070124.04748.arnd@arndb.de>
	<20070806233630.95E233B0080@mail28-fra.bigfish.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/6/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> > On Tuesday 07 August 2007, Wolfgang Reissnegger wrote:
> > >
> > > Make support for Xilinx boards more generic, making it easier
> > > to add new boards. Add initial support for xupv2p and ml410 boards.
> >
> > I really think we shouldn't add stuff to arch/ppc at this point,
> > it has been deprecated for over two years now.
>
> This is a good point...  In fact the other patch (although tiny) is
> more important, since it affects drivers, which should work in
> arch/powerpc.  Thanks for the feedback anyway!
>
> On this topic: has anyone tried using the recent Walnut patches for
> arch/powerpc?   I briefly took a look at starting to port the Virtex
> support to arch/powerpc but I'm a bit lost as to where to start... :)

I plan to start hacking on it this week if things go well.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
