Date: Thu, 11 Oct 2001 17:35:21 +0200
From: Olaf Hering <olh@suse.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org, Herbert Duerr <duerr@sun.com>
Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Message-ID: <20011011173521.B6869@suse.de>
References: <200110111256.f9BCuuf07110@ashley.ivey.uwo.ca> <1002814351.12609.408.camel@pismo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1002814351.12609.408.camel@pismo>; from michdaen@iiic.ethz.ch on Thu, Oct 11, 2001 at 05:32:31PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 11, Michel Dänzer wrote:

> On Thu, 2001-10-11 at 14:53, Kevin Hendricks wrote:
>
> > >> I don't feel qualified to do that. Xpert@XFree86.Org is a mailing list
> > >> which the author of this code and other very competent XFree86 hackers read,
> > >> or if you're absolutely sure the fix is correct, please submit it to
> > >> fixes@XFree86.Org .
> >
> > Michel:
> >
> > I just don't see how using an uninitialized variable in an "if"
> > statement can be anything else but a bug.
>
> You're probably right. Never meant to say otherwise.
>
> > You could have at least looked at the code in question before replying.
>
> If I had enough time...
>
> > You are a member of XFree representing ppc linux aren't you?
>
> Yes, but I don't have any experience with this code, and I'm not member of
> the core team so I have to submit patches for inclusion as well. I was
> referring you to places I thought would allow for faster inclusion.
>
>
> > > keithp already put something in the CVS. It did not work with "ati", but
> > > with fbdev (clgen).
> > > The patch fixed it for me on the Pismo.
>
> So what's in CVS only works for fbdev, Kevin's patch is needed for r128?

Its clearly needed for everyone, Keith already did the commit a few
hours ago.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
