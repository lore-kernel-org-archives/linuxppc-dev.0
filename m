Message-Id: <v04003a07b9011589bb75@[24.70.162.28]>
In-Reply-To: <20020510010614.1e4aa78a.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 May 2002 01:14:51 -0500
To: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: uneject command for CDROM?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:06 AM -0500 5/10/02, Bill Fink wrote:
>Silly question that occurred to me at 1 AM:
>
>Would it be possible to have an uneject command for the CDROM/DVDROM
>that would put the CD tray back in the machine?  Or maybe the eject
>command could be made to do this if the tray was already out.  I'm
>just getting tired of having to manually push it back in.

If 'eject -t' works with your drive, use that. More info in the eject(1)
manpage.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
