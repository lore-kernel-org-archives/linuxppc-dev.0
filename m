Return-Path: <daren.hayward@4bridgeworks.com>
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD450294288@NTSERVER4>
From: zDL Linux PPC <linuxppc@4bridgeworks.com>
To: 'Gerhard Jaeger' <g.jaeger@sysgo.com>
Date: Thu, 24 Feb 2005 13:55:33 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: zML Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	zML Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: Power PC 440GX Jumbo Packets EMAC2/3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard,

> [SNIPSNAP]
> > > > Any suggestions on how to overcome this problem??? My only 
> > > idea is to either
> > > > add data to the packet (don't think this will work) or 
> > > forceably fragment
> > > > the packet (if it is 2K in size) to ensure that it never 
> > > uses the exact size
> > > > of the tx fifo.....
> > > 
> > > Have you applied Matt Porters patch? It has been submitted at 
> > > the beginning
> > > of this month?
> > 
> > No I haven't seen it on either of these lists, do you know 
> where I can find
> > it 
> > 
> > Thanks
> 
> Browse the linuxpp-embedded archive list, I think it was 
> around the 9th
> of february...
> or try this one
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-February/00
1260.html

Thanks for this however it is not the problem I am experiencing at present,
my problem is with the TX and not the RX side of things, I have added debug
and the ibm_emac_core prints out that the packet has been transmitted,
however I see nothing at the other end when you transmit a packet of tx fifo
size bytes from the PPC 440 GX, packets of <tx fifo size or >tx fifo size
are transmitted fine from the PPC 440 GX, so long as you do not transmit a
packet of Tx fifo size.

Thanks
