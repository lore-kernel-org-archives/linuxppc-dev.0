Message-ID: <B164B53F5BD6D511888D009027732E1A0249AF@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Dan Malek'" <dan@embeddededge.com>,
	Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ATM switching in MPC8260
Date: Thu, 6 Dec 2001 09:18:25 +1100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> > I have to do some ATM traffic switching
>
> I'm not sure what you mean by "traffic switching."  The 603 core
> needs to be involved for some management of the connections.  I've
> done custom Ethernet bridging applications over ATM using the AAL5
> and it has worked well.


Management is fine, but I do not want core to process traffic. In case of
AAL2, itcan be programmed to do switching and switching will happen
automatically in CPM.
For AAL0 this is from 8260 manual: "Automatic data forwardingcan be used to
switch AAL0 cells from one ATM port to another without core intervention".
(29.9.8 ATM-to-ATM Data Forwarding).
No mention of AAL5, though.


>
> With AAL5 you just hand the CPM a PDU for transmit, and the receiver
> returns the PDU in the receive buffer.  The CPM does all of the cell
> fragmentation, CRC and length checks, and header processing.
>
> There are many nice features of this ATM controller, including things
> like bit rate and cell scheduling.  I suspect the whole of
> the Linux ATM
> software can be done by the CPM (and then some), all we need is a data
> path and control interface.

Yes, ATM controller is very powerful and flexible. Motorola did a good job!

Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
