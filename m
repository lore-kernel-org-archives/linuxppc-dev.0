Message-Id: <5.2.0.9.2.20021202162114.01d3dad0@mail.lauterbach.com>
Date: Mon, 02 Dec 2002 16:35:05 +0100
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200212021011.55105.kevin.hendricks@sympatico.ca>
References: <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
 <jeisycebok.fsf@sykes.suse.de>
 <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 16:11 02.12.2002, Kevin B. Hendricks wrote:

>Hi,
>
>Here is what Sun's Hamburg developers wrote in reply...
>
> > Hi Kevin,
> >
> > -fstrict-aliasing is in -O2 optimization since gcc-3.0.x. And no, our
> > code is not strict alias safe. You'll get some problems, I know of at
> > least one place in sc. I bet there are more.
> >
> > I recommend to use -O2 -fno-strict-aliasing. This is what Hamburg
> > release engineering currently uses.
> >
> > If someone is able to identify all strict alias violating places I would
> > be more than happy to propose that we change these (or add the
> > -fno-strict-alias to just these files).
> >
> > Heiner
>
>So it looks like Solaris and Win must not detect these issues already.
>So a backport of the gcc 3.3 warning flag would certainly be a big help to
>the OOo project as well.

I see, but I think there is no chance that this is backported to an
official 3.2 release. Also 3.3 is only a few month away, so it makes no
real sense.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
