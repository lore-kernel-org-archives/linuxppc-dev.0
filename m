From: Alan Mimms <alan@packetengines.com>
To: Dan Malek <dan@netx4.com>, "Robin O'Leary" <robin@equiinet.com>
Subject: Re: linux-2.3.37 / 2.3.18 / 2.2.13
Date: Mon, 10 Jan 2000 15:32:06 -0800
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20000107213528.A29581@mail.ro.nu> <20000110211045.F8416@mail.ro.nu> <387A5FD5.33A21291@netx4.com>
In-Reply-To: <387A5FD5.33A21291@netx4.com>
MIME-Version: 1.0
Message-Id: <00011015324501.02687@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan, the lack of RAMDISK support is still on Alan/Linus's "must do" list
before 2.3.x can become 2.4.x.  That would seem to imply that the necessary
work has not been done.

a

On Mon, 10 Jan 2000, Dan Malek wrote: > Robin O'Leary
wrote: >  > 
> > ....  Although I have now
> > coaxed 2.3.18 as far as trying to load the initrd, it has been an uphill
> > struggle all the way and I still haven't got the compressed bootloader
> > going properly.  Could it be that my problems stem from using 2.3.18?
> 
> 
> As I recall, the ram disk didn't work in 2.3.18.  There are some
> general things that don't work in 2.3.18, so I bailed out and
> updated 2.2.xx to get something stable.  Since 2.3.xx is now
> in it's mid-30's (still younger than I :-), perhaps it is mature
> enough that I should visit again and make sure the 8xx configuration
> continues to work.
> 
> 
> 	-- Dan
-- 
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
