To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: mlan@cpu.lu, ldl@chpc.utah.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1 
In-reply-to: Your message of "Wed, 15 Sep 1999 13:05:10 EDT."
             <199909151707.MAA16408@lists.linuxppc.org>
References: <199909151707.MAA16408@lists.linuxppc.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Sep 1999 14:26:55 -0400
From: Kevin Puetz <puetzk@iastate.edu>
Message-Id: <E11RKhj-0001UA-00@puetz.penguinpowered.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



khendricks@admin.ivey.uwo.ca said:
> Hi,
> Just to add fuel to the fire (although I am not sure if this is
> related or not)

> My B+W G3 rev2 with 16MB of vram has never ever detected the correct
> amount.  In  fact, if I run Xconfigurator, it tells me I have less
> then 1MB of vram and  therefore won't let me use any of the higher
> resolutions that should work

> The interesting thing is that if I change my bpp via the MacOS,
> Xconfigurator  reports completely different amounts of vram available
> and not in any logical  way that I can see.

If you use 'no video driver' Linux will see the amount of VRAM that was 
actually in use by MacOS when booting. You should probably look into a newer 
kernel with aty128fb

> Any fixes along these lines would be greatly appreciated (this is with
> Paul's  2.2.10 stable kernel available from his website).

Which is probably just old enough not to have the correct driver.

> Just thought someone in the know should be told :-)

> Kevin 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
