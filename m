Date: Fri, 10 May 2002 02:40:18 -0400
From: Bill Fink <billfink@mindspring.com>
To: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: uneject command for CDROM?
Message-Id: <20020510024018.4459ba69.billfink@mindspring.com>
In-Reply-To: <v04003a07b9011589bb75@[24.70.162.28]>
References: <20020510010614.1e4aa78a.billfink@mindspring.com>
	<v04003a07b9011589bb75@[24.70.162.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 May 2002, Tony 'Nicoya' Mantler wrote:

> At 12:06 AM -0500 5/10/02, Bill Fink wrote:
> >Silly question that occurred to me at 1 AM:
> >
> >Would it be possible to have an uneject command for the CDROM/DVDROM
> >that would put the CD tray back in the machine?  Or maybe the eject
> >command could be made to do this if the tray was already out.  I'm
> >just getting tired of having to manually push it back in.
>
> If 'eject -t' works with your drive, use that. More info in the eject(1)
> manpage.

Hi Tony (and also David Blythe who replied privately),

Thanks!  Somehow I missed that option on my first pass of the eject
man page (must be time to go to sleep).  And it does work on my drive.
Now I'll just alias uneject to 'eject -t' and I'll be all set.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
