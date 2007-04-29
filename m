Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17972.22463.103425.51542@cargo.ozlabs.ibm.com>
Date: Sun, 29 Apr 2007 18:30:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
In-Reply-To: <1177695045.24866.135.camel@luke-laptop>
References: <1177626236.24866.99.camel@luke-laptop>
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
	<c21def285f4ad2e13914af73f7610c0b@bga.com>
	<1177695045.24866.135.camel@luke-laptop>
Cc: Arnd Bergmann <arnd@arndb.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Luke Browning writes:

> How about the following as an alternative. 
> 
>   BUG_ON((hpte_v & 0x4000000000000000UL) && (crashing_cpus == -1));
>   BUG_ON((size == MMU_PAGE_16G) && (crashing_cpus == -1));
>   BUG_ON((size == MMU_PAGE_64K_AP) && (crashing_cpus == -1));

How much effort would it be to add the code to cope with those
conditions and give the correct answers?  I'd much prefer that to
these BUG_ONs.

Paul.
