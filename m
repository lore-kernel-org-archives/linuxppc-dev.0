Message-Id: <5.1.0.14.2.20020510110227.0236c938@falcon.si.com>
Date: Fri, 10 May 2002 11:06:21 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEMJDGAA.acurtis@onz.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00A@mail.mediatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The 8260's 1 second timer is only useful if your hardware clocks the "RTC"
clock input at the proper rate.  A lot of embedded boards don't bother
because the usefulness of having another crystal on the board just to clock
a counter is very tenuous.

gvb


At 07:23 AM 5/10/2002 -0700, Allen Curtis wrote:

>FYI: There is a 1 second timer in the 8260 that could be used. (Assuming
>that I understand what you are referring to) I am not sure why m8260_setup.c
>just sets/returns a global variable but there is/was a note there mentioning
>the 1 second timer. This is what we are using. It is actually started in our
>BIOS but could be done just as easily in the setup routine.
>
> > My platform uses an 8260 processor, and AFAIK there is no RTC.
> > The function
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
