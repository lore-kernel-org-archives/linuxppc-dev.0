Date: Thu, 13 Jul 2000 20:35:07 +0200
From: Olaf Hering <olh@suse.de>
To: Josh Huber <huber@mclinux.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: > 512 MB of ram on G4?
Message-ID: <20000713203507.A8255@suse.de>
References: <20000713142202.A1289@mclx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000713142202.A1289@mclx.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 13, Josh Huber wrote:

> Hey, I'm trying to put 1GB of ram in an Apple G4 box here, but I'm having
> trouble.  Anything higher (well, in increments of 256M) is dumping me into
> xmon early on boot (before the fbcons is initialized).
>
> Any thoughts?  I'm unable to use xmon because of the USB
> keyboard...unfortunately.  Too bad Apple didn't put a real serial port on
> these machines :(

use mem= as argument, the highest mem I got was mem=703M.





Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
