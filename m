Return-Path: <daren.hayward@4bridgeworks.com>
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD450294286@NTSERVER4>
From: zDL Linux PPC <linuxppc@4bridgeworks.com>
To: 'Gerhard Jaeger' <g.jaeger@sysgo.com>,
	zML Linux PPC Dev <linuxppc-dev@ozlabs.org>
Date: Thu, 24 Feb 2005 13:12:21 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: zML Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: Power PC 440GX Jumbo Packets EMAC2/3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thursday 24 February 2005 12:46, zDL Linux PPC wrote:
> > I have been doing some experiments with Jumbo packets (MTU 
> 9000) and have
> > noticed that once you exceed the 2KB fifo size, I end up 
> with no response
> > from the box.
> > 
> > I can ping the box with no problem at all at sizes greater 
> than 2KB, however
> > upon further investigation I noticed packets of size 2006 
> bytes causes no
> > further packet to be transmitted (adding debug prints to 
> ibm_emac_core.c,
> > the driver believes the packet has been transmitted), after 
> adding a further
> > 42 bytes of header information this comes to the exact size 
> of the Transmit
> > Fifo 2048 (2KB). I have also changed the Transmit Fifo 
> Register to 1024
> > bytes, this solves the problem at 2006 bytes however now it 
> has moved to 982
> > bytes of data (+42bytes of header = 1024)
> > 
> > Has anyone else experienced this problem while either using 
> a smaller
> > transmit fifo (512 or 1024 bytes) and  MTU 1500 or a larger 
> MTU (>2033) and
> > EMAC transmit fifo of 2048. I guess this will really apply 
> to people with
> > larger MTU not many will decrease the Tx fifo, and I am 
> further guessing
> > that not many are using 9000 MTU as not much hardware seems 
> to support it, I
> > can only use it through a direct connection between PC's 
> and not through a
> > switch!
> > 
> > Any suggestions on how to overcome this problem??? My only 
> idea is to either
> > add data to the packet (don't think this will work) or 
> forceably fragment
> > the packet (if it is 2K in size) to ensure that it never 
> uses the exact size
> > of the tx fifo.....
> 
> Have you applied Matt Porters patch? It has been submitted at 
> the beginning
> of this month?

No I haven't seen it on either of these lists, do you know where I can find
it 

Thanks
