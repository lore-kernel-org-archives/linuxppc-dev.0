Subject: Re: Max swap size ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0112031753420.21063-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0112031753420.21063-100000@blues.wcg.mcgill.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 04 Dec 2001 17:14:12 +0100
Message-Id: <1007482452.21511.10.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2001-12-04 at 00:04, Christopher Murtagh wrote:

>  I have a machine running YDL (Dual 800Mhz, 1GB RAM) with a 2.4.13 SMP
> kernel (YellowDog's stock SMP kernel) that has a 512 MB swap partition.
> When I tried to install on other machines, they wouldn't boot with a swap
> partition that big, but for some reason this one did. It wasn't until
> after the other machines wouldn't boot did I notice in the TerraSoft docs
> that 256MB was the max.

That used to be the case before kernel 2.2 IIRC. Nowadays the limit is
in the gigabytes. FWIW I'm using a 400 meg swap partition without
problems.

> The machine ran beautifully until today when it did a nasty crash. My gut
> feeling is that it crashed when it tried to write to the swap for the
> first time as it was inching up to using almost all available RAM when
> it died.

Are you sure it only hit swap then? I can't remember ever seeing active
but completely unused swap space, even when RAM usage was low.


The bottom line is yes, you likely have another problem.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
