Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Add second POWER8 PVR entry
In-reply-to: <51E788D4.4000809@linux.vnet.ibm.com>
References: <16137.1374111111@ale.ozlabs.ibm.com>
 <51E788D4.4000809@linux.vnet.ibm.com>
Date: Thu, 18 Jul 2013 16:25:05 +1000
Message-ID: <32299.1374128705@ale.ozlabs.ibm.com>
Cc: miltonm@realtime.net, Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 07/18/2013 07:01 AM, Michael Neuling wrote:
> > POWER8 comes with two different PVRs.  This patch enables the additional
> > PVR in the cputable.
> > 
> > The existing entry (PVR=0x4b) is renamed to POWER8E and the new entry
> > (PVR=0x4d) is given POWER8.
> 
> Hey Mikey,
> 
> Is there any feature or architectural difference between these two different
> PVR based P8 chips ?

I've kept the CPU_FTRs the same.

Mikey
