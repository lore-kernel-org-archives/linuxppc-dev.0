Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D7D962BDCF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:49:59 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Sep 2004 06:59:22 EDT."
	<Pine.LNX.4.60.0409210644150.9187@dell.enoriver.com>
Date: Tue, 21 Sep 2004 13:49:51 +0200
Sender: wd@denx.de
Message-Id: <20040921114956.E5B2DC108D@atlas.denx.de>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409210644150.9187@dell.enoriver.com> you wrote:
> 
> > In message <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com> you wrote:
> >>
> >>    rather than get into more detailed discussion on microcode patches,
> >> here's a (partial) patch that represents what i'd really, really,
     ^^^^^^^^^^^^^^^^^^^^^^^^
...
> what i was showing was just an example, it didn't need to represent 
> *exactly* the set of choices that would be in the final menu.  if the 

Ummm. To me "partial patch" means that this is an excerpt of  exactly
the  patch you want to see applied. Please write "example" if this is
what you mean.

> above is the case, that's fine.  but there's still then, at the very 
> least, the list of possible patches that are in *your* 2.4 kernel 
> source tree.  i wasn't submitting a final list of patches, just a 

Please forget our tree for this discussionhere, it is  not  relevant.
Also,  I  wrote  you before that the uCode stuff was only tested in a
small number of specific configurations, and that it is KNOWN  TO  BE
BROKEN for many configurations, including most newer 8xx processors.

> suggested *format* for selection, that's all.  don't get ahead of me 
> here.

It looked like a ready-to-sumbit patch, and you announced it as such.

> >>    it adds a simple choice entry to the MPC8xx menu, from which you can
> >> select the appropriate patch -- it's as easy as that.
> >
> > No, it is not that easy.
> 
> yes, it is.

OK. I give up here. I've explained  the  complexity  (like  processor
variants,  like  incompatible  changes of the relocation base address
pointer between versions, etc.) several times  before.  You  seem  to
know better...

> > Indeed. And AFAICT there is no way to get the processor version  from
> > any  other CONFIG option that the board name, so this would become an
> > awfully long list.
> 
> in what way?  the denx 2.4 kernel source tree defines all of 5 
> patches.  i don't see that as an overly long list, and given that the 
> default selection would be "None", people who don't even know what a 
> patch is would never have to make that decision.

It was _you_ who asked for a "simple" configuration  where  you  just
enable  a uCode patch, and where the kernel config tool does not even
offer selections that don;t apply to a specific board. It  was  _you_
who  posted  a  "(partial) patch" which did not mention that you will
violate your own requirements.

> at the moment, your denx tree supports a number of patches that 
> require users to edit source files and manually define constants. in 
> what way is this a better idea than picking from a drop down choice 
> list?

It is not better. Nobody ever claimed that. See above.

> (and i never suggested that the config process automatically detect 
> the 850 or non-850-ness of the processor.  that would be a manual 

Yes, you did. Quote Robert P. J. Day (22 Jul 2004 08:00:01 -0400):

	...
	   perhaps overly ambitious, but it would be *really* cool if the
	patches presented to the developer were tied to the underlying
	processor.  that is, once you've selected, say, RPXlite, the only
	patches displayed in the menu should be those relevant to the rpxlite.
	...

> me: "um ... ok, what about a patch like this?"
> reply: "no."

Just look at this discussion today: you post a "(partial) patch", and
when I point out problems with it you say, "umm, that's not the  real
patch,  it's  just  an example, but it needs to be fixed and extended
and actually you goot make it working first." I claim that it's  more
complex  than  this,  you deny this, and then add that of course more
manual selections need to be added.

I have to admit that I don't understand what _exactly_ you suggest.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is easier to write an incorrect program than understand a  correct
one.
