Message-Id: <4.2.0.58.19990709161235.03b8de80@mail.lauterbach.com>
Date: Fri, 09 Jul 1999 17:43:48 +0200
To: Tom Rini <trini@disparity.net>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: platinum video makes me cry...
Cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        Mark Abene <phiber@radicalmedia.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSF.3.96.990709093050.70746F-100000@silver.teardrop.n
 et>
References: <Pine.LNX.3.96L.990708142815.2134H-100000@unix47.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 15:32 09.07.99 , Tom Rini wrote:

>On Thu, 8 Jul 1999, Hollis R Blanchard wrote:
>
> >
> > On Thu, 8 Jul 1999, Mark Abene wrote:
> > >
> > > The good news is that I finally got around to installing 
> linuxppc-1999 (R5)
> > > on my 7200.  The BAD news is that much to my chagrin, the changes I 
> made to
> > > fix the platinum video driver in the newer kernels (which I submitted 
> to the
> > > code maintainer nearly a month ago, if not more) are NOT present in R5!
> > > I was greeted by the sickly-looking psychedelic arch-nemesis of Tux the
> > > penguin.
> > > Suffice to say, gnome came up looking like a bad acid trip.
> >
> > Strangely enough, the kernel the installer uses was right. I was very
> > pleasently surprised to see Tux in the correct colors when I went to 
> install.
> > Of course, the kernel the installer actually installs is screwed up in this
> > respect.
>
>Well, 1) Did the installer endup using no video driver? (I still don't
>have a CD pair, have to bug jeff again once i settle in) 2) iirc, about a
>month ago Geert (the video maintainer) was working towards his PhD and
>could have easily lost the mail. 3) Where is the patch anyhow, there'll no
>doubt be a kernel upgrade "soon" :)

The fix is in 2.2.10vger (and was in later 2.2.9vger as well). Geert 
accepted it nearly immediately, but probably feeding it to 2.2.10linus 
didn't happen in time.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
