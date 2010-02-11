Return-Path: <dwg@au1.ibm.com>
Date: Thu, 11 Feb 2010 14:55:16 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/04] powerpc/booke: Introduce new CONFIG options for
	advanced debug registers
Message-ID: <20100211035516.GO13335@yookeroo>
References: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
	<20100208215057.17930.30833.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208215057.17930.30833.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2010 at 02:50:57PM -0700, Dave Kleikamp wrote:
> powerpc/booke: Introduce new CONFIG options for advanced debug registers
> 
> From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> 
> Introduce new config options to simplify the ifdefs pertaining to the
> advanced debug registers for booke and 40x processors:
> 
> CONFIG_PPC_ADV_DEBUG_REGS - boolean: true for dac-based processors
> CONFIG_PPC_ADV_DEBUG_IACS - number of IAC registers
> CONFIG_PPC_ADV_DEBUG_DACS - number of DAC registers
> CONFIG_PPC_ADV_DEBUG_DVCS - number of DVC registers
> CONFIG_PPC_ADV_DEBUG_DAC_RANGE - DAC ranges supported
> 
> Beginning conservatively, since I only have the facilities to test 440
> hardware.  I believe all 40x and booke platforms support at least 2 IAC
> and 2 DAC registers.  For 440, 4 IAC and 2 DVC registers are enabled, as
> well as the DAC ranges.

Hrm.  I'm not entirely convinced there aren't or won't be 44x chips
with a different number of regs.  Still we fix it up to do runtime
checking later.

> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Acked-by: David Gibson <dwg@au1.ibm.com>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
