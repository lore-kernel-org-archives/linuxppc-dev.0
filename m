Date: Sun, 7 Mar 1999 19:14:21 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: "David Mentr\\'e" <David.Mentre@irisa.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux SMP FAQ] Info request for SMP PPC systems Linux support
In-Reply-To: <wd8d82m7cjn.fsf@parate.irisa.fr>
Message-ID: <Pine.LNX.4.04.9903071902330.25081-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 6 Mar 1999, David Mentr\'e wrote:

> 
> [ as I'm not on this list, so please Cc: to me any answer. Thanks. ]
> 
>  Hello all LinuxPPC developpers,
> 
> I'm the maintainer of the Linux SMP FAQ (see pointer below if you want
> to have a look). Right know, this FAQ is very x86 centric but I plan to
> change that. Looking at linuxppc.org, it seems that :
> 
>  - support is beeing developed (by lead programmer Cort Dougan )for
>    PowerSurge boards. This includes the UMAX s900.
> 
>  - support for SMP PowerMac is working.

Let me add: 

Motorola MTX (and probably dual CPU MVME boards) have early (working)
support for SMP. Dual CPU have two 604e chips running at 300, 333, or 400
mhz, fyi.

Support for the MTX isn't fully complete, the MTX board I use is
reasonably stable. It will, however crash with more than 2 or 3 large
compiles running.

> So here are my questions :
> 
>  1. what is the current status of SMP support for LinuxPPC? any table? 
> 
>  2. is there any specific things to do to make a PPC SMP system?
>     (kernel compilation, boot, etc.)

PowerMac SMP is similiar to standard PowerMac. The MTX booting process is
somewhat involved, and the MTX SMP code is not in the mainline kernel yet.
 
>  3. is there a mailing-list I should subscribe to to have further info
>     on this subject (i.e. SMP && PPC && Linux)?
> 
>  4. any bench result of SMP system?

Do you have any suggested benchmarks?

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
