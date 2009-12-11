Return-Path: <dwg@au1.ibm.com>
Date: Fri, 11 Dec 2009 14:28:15 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers
	on BookE Platforms
Message-ID: <20091211032815.GD8852@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
	<1134F495-6623-437F-AF1F-64D0A87BA112@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134F495-6623-437F-AF1F-64D0A87BA112@kernel.crashing.org>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 08:41:53PM -0600, Kumar Gala wrote:
[snip]
> > +#define DBCR1_USER_DEBUG	(DBCR1_IAC12M | DBCR1_IAC34M)
> > +#define DBCR1_BASE_REG_VALUE	(DBCR1_IAC1US | DBCR1_IAC1ER_10 | \
> > +				 DBCR1_IAC2US | DBCR1_IAC2ER_10 | \
> > +				 DBCR1_IAC3US | DBCR1_IAC3ER_10 | \
> > +				 DBCR1_IAC4US | DBCR1_IAC4ER_10)
> 
> We are we using MSR[IS] IS=0, why not just any Eff address?  In the
> future we might have user as IS = 1, and kernel as IS = 0.

Since the user can't control that directly, we can update this when
and if we change our use of address spaces.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
