Message-Id: <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
Date: Mon, 02 Dec 2002 15:51:27 +0100
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200212020937.56585.kevin.hendricks@sympatico.ca>
References: <jeisycebok.fsf@sykes.suse.de>
 <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
 <200212020914.21465.kevin.hendricks@sympatico.ca>
 <jeisycebok.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 15:37 02.12.2002, Kevin B. Hendricks wrote:

>Hi,
>
> > |> Is there any warning flag that can be enabled to help find these
> > |> cases (the OOo source base is simply huge)?
> >
> > gcc 3.3 implements such a warning, but it may give many false positives.
>
>Any chance we can get this flag backported so that it appears in gcc 3.2.2?
>
>False positives are a whole lot better than code that quietly does the an
>unexpected thing.

Well, are you sure OO is really affected? strict-aliasing is the default
since gcc-2.96 which means that everything since redhat-7.0 would be
affected on x86 for example. Also GCC has been very late to make this the
default at all, I think that Sun and MS compilers do this for years
already. I would be very surprised if a multiplatform project like OO still
contained reasonable amounts of aliasing-unsafe code.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
