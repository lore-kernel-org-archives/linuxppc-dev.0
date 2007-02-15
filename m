Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch v3] powerpc: add PMI driver for cell blade
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heiko J Schick <info@schihei.de>
In-Reply-To: <8093459E-094C-4BE6-B2DB-DB218F978733@schihei.de>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost> <20070209222956.GH1827@localdomain>
	<20070212101222.24abe14c@localhost> <20070213143418.06fa01b5@localhost>
	<20070213194436.0306d18a@localhost> <20070213194806.3c266282@localhost>
	<20070213202854.09332582@localhost>
	<17874.22587.981499.55058@cargo.ozlabs.ibm.com>
	<20070214093941.08ec4c7f@localhost>
	<17874.58072.316004.517233@cargo.ozlabs.ibm.com>
	<20070214140743.18fafe37@localhost> <20070214140945.4ad0d772@localhost>
	<8093459E-094C-4BE6-B2DB-DB218F978733@schihei.de>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 21:50:46 +1100
Message-Id: <1171536647.5644.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Krafft <parabelboi@bopserverein.de>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>,
	Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 08:06 +0100, Heiko J Schick wrote:
> Hello Christian,
> 
> On 14.02.2007, at 14:09, Christian Krafft wrote:
> 
> > +	{ .type = "ibm,pmi", .name = "ibm,pmi" },
> 
> In the FW the device name is still "pmi" - only the type is "ibm,pmi".
> 
> I think it is better to rename it to "ibm,pmi", since PMI is a quite  
> common abbreviation.

Nah, the name doesn't matter that much as long as it's unique at a given
level, just keep it to "pmi"

Ben.
