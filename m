Date: Thu, 23 Aug 2001 19:06:42 +0200
From: Olaf Hering <olh@suse.de>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-benh0 problems and kudos
Message-ID: <20010823190642.A27997@suse.de>
References: <20010823164256.8751.qmail@kunk.jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010823164256.8751.qmail@kunk.jriver.com>; from bob@kunk.jriver.com on Thu, Aug 23, 2001 at 11:42:56AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 23, Robert E Brose II wrote:

>
> On the positive side it looks like the 7500 chaos PCI bus fixes
> have been incorporated as well as the planb fixes and the
> controlfb enhancements.
>
> I've run into a couple of small problems however....
>
> planb.c has a problem in 2074.
> pb->lock = 0;
>
> pb->lock is defined as a semaphore so this gives the following
> compiler error...
>
> planb.c: In function `init_planb':
> planb.c:2074: incompatible types in assignment

try that one and see how it goes.
http://www.penguinppc.org/~olaf/ibook2/patches/70__01_00_2.4.6-pre8-fixes.gz


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
