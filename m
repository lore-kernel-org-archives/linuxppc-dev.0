Subject: Re: External Monitor under Pismo
From: Tuomas Kuosmanen <tigert@ximian.com>
To: Jason "E." Stewart <jason@openinformatics.com>
Cc: Andrew Sharp <andy@netfall.com>,
	Jason "E." Stewart <jason@openinformatics.com>,
	debian-powerpc@lists.debian.org, stewart.sadler@roke.co.uk,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <87lmph4e1b.fsf@amadeus.openinformatics.com>
References: <87vgonhx7p.fsf@amadeus.openinformatics.com>
	<3AC9B2DC.1567BC90@netfall.com> <986310913.29215.0.camel@spectrolite>
	<87lmph4e1b.fsf@amadeus.openinformatics.com>
Content-Type: text/plain
Date: 04 Apr 2001 11:38:52 +0300
Message-Id: <986373532.30396.0.camel@spectrolite>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 03 Apr 2001 19:03:28 -0700, Jason E. Stewart wrote:
> "Tuomas Kuosmanen" <tigert@ximian.com> writes:
>
> > Hi!
> >
> > "mirror" works fine for me even on kernel 2.4.3 on my Pismo. Weird. This
> > kernel is from Ben's rsync and it contains the pismo sleep code as well.
> >
> >     rsync -avz --delete penguinppc.org::linux-2.4-benh linux-2.4-benh
> >
> > I got scared because I am going to GUADEC (a GNOME conference in
> > Denmark) this weekend and it would have sucked badly if it didnt work,
> > but so far it looks good :o)
> >
> > I originally had just a binary of "mirror" which worked, but I compiled
> > the one which was attached to Jason's mail and it worked as well.
>
> Glad it helped. I updated my copy of 2.4-benh, and it works now???!!!
> So I'm really happy ;-)
>
> Now...
>
> Since I'm mirroring the LCD I only get 1024x768, and the pismo can
> drive a 1600x1200@16 bit depth. So what needs to happen to aty128fb.c
> to support the external monitor, and what can I do to make it happen??
>

That is beyond *me* but maybe someone else knows. I am just the artist
dude 'round the corner who likes to hack with perl and stuff.. :-)

I think there is no support for the external monitor in that sense in
the driver. In macos it can do real dualhead, so that would be possible
at least in theory, and it would be pretty nice. But currently I think
the mirrored display is all we have for Pismo. Which works nice for
projectors though.

Tuomas


________________________________________________________________________

Tuomas Kuosmanen - Art Director -
Ximian - tigert@ximian.com -
www.ximian.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
