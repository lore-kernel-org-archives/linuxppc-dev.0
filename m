To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: [PATCH] aty128fb.c
Message-ID: <1005303565.3bebb70d6b4f9@imp3-1.free.fr>
Date: Fri, 09 Nov 2001 11:59:25 +0100 (MET)
From: Bastien Nocera <hadess@hadess.net>
Cc: Bastien Nocera <hadess@hadess.net>,
	"Jeramy B. Smith" <jeramy@penguinppc.org>,
	linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.33.0111090300500.737-100000@penguinppc.org> <1005301549.3bebaf2d1e55f@imp.free.fr> <3BEBB59E.3060202@humboldt.co.uk>
In-Reply-To: <3BEBB59E.3060202@humboldt.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Quoting Adrian Cox <adrian@humboldt.co.uk>:

>
> Bastien Nocera wrote:
>
> > Quoting "Jeramy B. Smith" <jeramy@penguinppc.org>:
> >>This removes a block of cruft leftover from the iMac days and sets
> the
> >>default resolution for aty128fb on PPCs to 640x480-60 (ensuring even
> >>the
> >>cruddiest of monitors will work).
> > The iBook2 doesn't support 640x480 afaik
>
>
> That should be dealt with by these lines:
>
> 	    /* PowerBook Firewire (Pismo), iBook Dual USB */
> 	    if (machine_is_compatible("PowerBook3,1") ||
> 	    	machine_is_compatible("PowerBook4,1"))
> 		default_vmode = VMODE_1024_768_60;

Hmm, is that already in the sources ?
I'm sorry, I only read the patch, and I'm a bit tired as well.

Thanks for pointing me out

/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
