Message-ID: <3CF79C16.4B547602@esteem.com>
Date: Fri, 31 May 2002 08:51:50 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Poor 8260 FCC Ethernet performance
References: <NCBBIINEHIPFGJPLBEIFCEOADHAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
>
> > The 8260 Ethernet controller needs to know about the duplex mode in which
> > the PHY operates. The driver sets it to half duplex by default, and needs
> > the feed back of the PHY to set it to full duplex.
> >
> > As you may know, the hub always operates in half duplex, while the switch
> > usually operates in full duplex, if it is directly connected to your unit,
> > and your PHY accepts to negociate to full duplex.
> >
>
> Yes, the source code has been modified to force full-duplex.
> (fcc_restart(dev,1) if I remember correctly :) In fact, before this change
> was made Ethernet communications did not work at all. (At least it would not
> get past bootp) I searched for something that looked like it was speed
> related but found nothing. (Other than the MII reporting)
>
> Other ideas?

Could it be an analog problem? Have you looked at the signals comming in on
a scope?


>
> BTW: We are using a BCM switch for our PHY. The interface to the processor
> is always full-duplex, 100BT regardless of the external connections. Hence
> the no MII PHY option.

Let me get this straight, You have no PHY, no magnet, no connector? If this
is the case are you sure your voltages on the I/O compatible?

I have thought about building a Beowolf cluster in this manner out of 8260s
just to impress my geek friends and colleages. Of course I don't have the
time or money to do it, but its fun to think about.

Good Luck

	Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
