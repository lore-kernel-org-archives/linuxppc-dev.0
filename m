Message-ID: <38F379FB.54AC0986@worldnet.att.net>
Date: Tue, 11 Apr 2000 12:16:11 -0700
From: Logan Hall <warrior514@worldnet.att.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: what is wrong with kernel 2.3.x
References: <Pine.SOL.3.95.1000411201301.4181B-100000@juliet>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
>
> On Wed, 5 Apr 2000 18:22:05 -0400 (EDT), Scott Knight
> <scott@re-104-1.read.indiana.edu> wrote:
> >
> >       First off, right now Im using 2.3.51 but I saw the saem problems
> > with 2.3.99-pre3 from the linuxcare rsync. ON the console when using the
> > mouse to select stuff it inverts all the chareacteer sto weird thigns
> > rather than hilighting them. Als with sound. on my 8500 for some reason
> > the mixer for the microphone controls the rca input volume rather than the
> > rca input volume controlling what it should. I havent been able to get the
> > stable 2.2.x version from linuxcare to boot for some reason. All quite odd
> > and agrravating. Im on a powerpc 8500 upgraded to g3/300 with 160MB memoy
> > and 4MB vram with 2 2gig drives inside of it. Any and all insite would be
> > greatly apprecaited.
> >

I am seeing this too.  I just got 2.3.99-pre3 running on my G3 biege
tower (figgured out i had to include the powerbook adb stuff to
compile).  But on console when you use the mouse you get the garbage
characters.  Also with sound, the sound now comes out my internal
speaker rather than the speakers on my av monitor.  I have tried using
aumix but it gives the error:

MIXER_READ: Invalid argument

so i can't remix the sound to have it come out the monitors speekers.
Another odity i see is that the kernel seems to bring up my ethernet
interface (builtin) but the link light on the hub never lights up.  My
room mate isn't home and his computer isn't on so i cant see if the
ethernet works but i doubt it sence the light isn't on.  but the kernel
seems to th ink it works.  any ideas?


--

----
Logan Hall

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
