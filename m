From: tom_gall@vnet.ibm.com
Message-ID: <396E13E2.F49A37D1@vnet.ibm.com>
Date: Thu, 13 Jul 2000 19:09:22 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Josh Huber <huber@mclinux.com>
CC: Olaf Hering <olh@suse.de>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: > 512 MB of ram on G4?
References: <20000713142202.A1289@mclx.com> <20000713203507.A8255@suse.de> <20000713144024.A1379@mclx.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
>
> On Thu, Jul 13, 2000 at 08:35:07PM +0200, Olaf Hering wrote:
> > On Thu, Jul 13, Josh Huber wrote:
> >
> > > Hey, I'm trying to put 1GB of ram in an Apple G4 box here, but I'm having
> > > trouble.  Anything higher (well, in increments of 256M) is dumping me into
> > > xmon early on boot (before the fbcons is initialized).
> > >
> > > Any thoughts?  I'm unable to use xmon because of the USB
> > > keyboard...unfortunately.  Too bad Apple didn't put a real serial port on
> > > these machines :(
> >
> > use mem= as argument, the highest mem I got was mem=703M.
>
> So is it not (at this time) possible to use 1GB of memory on ppc?
>
> hmm.

Not yet ... 768 Meg is in theory the maximum. Hopefully in about 2 weeks this is
going to get fixed.

Regards,

Tom

Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
