Message-Id: <199907281336.PAA20067@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
cc: jpeters@phx.mcd.mot.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Motorola Web Site 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jul 1999 09:54:03 +0200."
             <m119OXL-0000WZC@tri-yann.crf.canon.fr>
Date: Wed, 28 Jul 1999 15:36:13 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <m119OXL-0000WZC@tri-yann.crf.canon.fr> you write:
> 
> While it is nce to have motorola *effectively* supporting linux

Yes - thanks, Motorola!

> may I make the follwoing comments :
> 
>     1) The form you need to fill to access patches is quite
>     painfull and if the purpose is only to notify users of
>     patch changes, then email would be sufficient...

Agreed. I do not like at all being forced to supply such  information
if I want or not. Please remove this!

You may add a link where anybody who *wants* notifications of changed
*may* register, but please do not try to force us!

An additional disadvantage  of  the  current  interface  is  that  it
disallows for automatic downloads using wget or similar tools.

>     2) The patch for 2.2.10 is 1.5 MB. It could have been 
>     compressed!!!

;-)

3) Is Motorola going to extend it's Linux support to the embedded controllers
   (MPC8xx, MPX82xx) ?

4) Running a diff against the original 2.2.10 distribution results in
   *all* files  being  different;  why  were  all  the  $Id$  strings
   changed?

   For instance - I guess there were not  so  many  changes  for  the
   Alpha prom code:

   -> diff linux-2.2.10/arch/mips/sgi/prom/misc.c linux_mot/arch/mips/sgi/prom/misc.c
   1c1
   < /* $Id: misc.c,v 1.6 1998/07/08 15:59:13 ralf Exp $
   ---
   > /* $Id: misc.c,v 1.3 1998/11/10 02:14:56 jpeters Exp $

   This makes it basicly impossible to find  out  what  *really*  was
   changed.

Wolfgang

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: -88  Home: -86  Email: wd@denx.muc.de
"Summit meetings tend to be like panda matings. The expectations  are
always high, and the results usually disappointing."   - Robert Orben

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
