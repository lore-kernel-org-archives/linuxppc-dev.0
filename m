Message-ID: <37B2C0A5.55A07C87@usa.net>
Date: Thu, 12 Aug 1999 08:40:06 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
CC: Naushit Sakarvadia <nsakarvadia@telogy.com>,
        LinuxPPC Developpers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Assembly
References: <XFMail.990812092025.heinz@bintec.de>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Heinz Blaettner wrote:

> On 11-Aug-99 Naushit Sakarvadia wrote:
> >
> > Hello,
> >
> > I am trying to learn assembly language of Powerpc.
> >
> > Anybody can suggest good point to start?
> >
> > I tried to read User Manual of MPC860 and InstrucionManual but
> > it doesnt talk about architecture of PPC,meas how many register it has...
> > how many flags..etc...
> >
> > I need something like programmer's guide ,which is not I couldnt find on
> > Motarola website.
> >
> Have a look at Motorola page:
>
>         www.mot-sps.com/home/lit_ord.html
>
>         order following doc's:
>         MCPFPE/AD
>         MPCPFE32B/AD
>         MPCPRG/D
>         MPCPRGREF/D

I'm not sure where I got it, but I have a nice book on PPC assembly that gives
quite a bit of help, called "Optimizing PowerPC Code", by Gary Kacmarcik.
It's a fairly early book, but not much has changed since the PowerPC was new.
All you need to know is that the 604 and up have three integer units instead
of one.

As far as registers go, the powerPC has 32 64-bit floating-point registers
(great for blitters) and 32 32-bit general purpose registers.there are also
several special registers (machine state, link, counter, rtc (only on 601),
etc).

Does anyone know if 64-bit powerPC's ever came out (e.g. the 620)?  I noticed
that the vger kernels (I think at least the 2.3 ones) have had them for a
while now.


--
--"Your mouse has been moved.  Windows 95 must be restarted for change to take
effect."


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
