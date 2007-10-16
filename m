Return-Path: <glikely@secretlab.ca>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.235])
	by ozlabs.org (Postfix) with ESMTP id 06744DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 13:02:13 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so1880159hud
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 20:02:11 -0700 (PDT)
Message-ID: <fa686aa40710152002l5bb2c746i8174827e8d66c746@mail.gmail.com>
Date: Mon, 15 Oct 2007 21:02:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Olof Johansson" <olof@lixom.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
Subject: Re: Refactor booting-without-of.txt
In-Reply-To: <20071016023845.GK26787@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071015165505.GA16040@lixom.net>
	<fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
	<20071016023845.GK26787@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Oct 15, 2007 at 11:14:44AM -0600, Grant Likely wrote:
> > On 10/15/07, Olof Johansson <olof@lixom.net> wrote:
> > > On Mon, Oct 15, 2007 at 10:08:44AM -0600, Grant Likely wrote:
> > > > Adding the Linux expected device tree bindings to
> > > > booting-without-of.txt seems to be getting a little unwieldy.  Plus
> > > > with more than one arch using the device tree (powerpc, sparc &
> > > > microblaze) the device tree bindings aren't necessarily powerpc only
> > > > (the Xilinx devices certainly fall in this category).
> > > >
> > > > Anyone have comments about splitting the expected device tree bindings
> > > > out of booting-without-of.txt into a separate directory?
> > >
> > > The flat device tree is, in spite of what some people would like it to be,
> > > not open firmware, nor is it the same as their bindings. So I think we'd
> > > be doing ourselves a disservice by continuing to associate them together.
> > > All it would take is a rename of the directory, unfortunately i don't
> > > have any suggestions on better names though.
> >
> > I think I need to stick with the of prefix.  All the support API in
> > include/linux/of_* is prefixed with "of_" already, so convention is
> > established.
> >
> > How about Documentation/of-device-tree?
>
> It seems a little counterintuitive to change names from "booting
> *without* of" to "of *"...

Heh; true.  The *only* reason I think it should be 'of-<anything>' is
because *all* the support APIs are named that way.  I'll happily use
another name if I get the impression that most of us in our little
group think it should be something else.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
