Return-Path: <g.jaeger@sysgo.com>
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc@4bridgeworks.com
Date: Thu, 24 Feb 2005 14:45:13 +0100
References: <C18BA5DDB58DD511BD0700C0DF0DD450294286@NTSERVER4>
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD450294286@NTSERVER4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502241445.14322.g.jaeger@sysgo.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: Power PC 440GX Jumbo Packets EMAC2/3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 February 2005 14:12, zDL Linux PPC wrote:
[SNIPSNAP]
> > > Any suggestions on how to overcome this problem??? My only 
> > idea is to either
> > > add data to the packet (don't think this will work) or 
> > forceably fragment
> > > the packet (if it is 2K in size) to ensure that it never 
> > uses the exact size
> > > of the tx fifo.....
> > 
> > Have you applied Matt Porters patch? It has been submitted at 
> > the beginning
> > of this month?
> 
> No I haven't seen it on either of these lists, do you know where I can find
> it 
> 
> Thanks

Browse the linuxpp-embedded archive list, I think it was around the 9th
of february...
or try this one
http://ozlabs.org/pipermail/linuxppc-embedded/2005-February/001260.html

Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
