Message-ID: <008001bff7f2$b24e85a0$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Joseph Garcia" <jpgarcia@execpc.com>, <sleemburg@jvc.nl>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <397FE132.1690D2DD@execpc.com> <397FE1BE.2416FE2@jvc.nl> <397FEEE5.265963BF@execpc.com>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
Date: Thu, 27 Jul 2000 13:46:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Stephan Leemburg wrote:
> > I wil put the code also in pmud itself. This should in fact be done at
> > kernel level, so a patch will be needed for the current tree.
>
> So would this always be done on wake to hdc and hde?  I read Pismos, and
maybe
> iBooks, have their drives at hde.  I'm not sure if they are afflicted by
this
> problem.

I have an iBook... the hard drive is /dev/hda, the CD-ROM is /dev/hdc. Same
thing on the G4 at home, not that that matters right now...

Later,
Robbie


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
