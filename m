Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id 0D3B967A83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 07:30:33 +1100 (EST)
Message-ID: <00c001c503e6$64369fb0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Dan Malek" <dan@embeddededge.com>,
	"annamaya" <annamaya@yahoo.com>
References: <20050126185350.20232.qmail@web53804.mail.yahoo.com>
	<BD936D78-6FCC-11D9-A0FB-003065F9B7DC@embeddededge.com>
Date: Wed, 26 Jan 2005 15:33:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is there a DER for the MPC82xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: "Dan Malek" <dan@embeddededge.com>

> 
> On Jan 26, 2005, at 10:53 AM, annamaya wrote:
> 
> > Can someone tell me if the BDI will be able to catch
> > all different kinds of exceptions/interrupts on the
> > MPC82xx without requiring any special register
> > programming? I am unable to find anything that that
> > resembles the DER register on the MPC8280.
> 
> The BDI2000 works very nicely on 82xx processors.
> The 82xx debug unit is the standard COP interface,
> completely different from the 8xx debug interface.
> Stop looking for a DER on the 82xx, plug in the
> BDI2000 and use it.  Make sure you understand all
> of the features of the BDI2000, as even on the 8xx
> you should not be worrying about the DER. Let the
> BDI2000 configure all of that accordingly based upon
> what you are asking it to do.
> 
> 

Well, the DER lets you look for multiple conditions at
once.  Your program is blowing up, the memory is
getting trashed and you don't even know if the hardware
is valid - that's where BDM really shines.  I don't see
where COP let's you do the equivalent of setting a
bunch of bits in the DER, so please enlighten us if
we're missing it!

Mark Chambers

P.S. I've read the BDI manual - I don't see it.  My manual
says the BDI can only set one hardware breakpoint, and
stuff like VECTOR CATCH assumes valid memory.  
