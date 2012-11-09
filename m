Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 00/14] powerpc: Add support for POWER8 relocation on
 exceptions
In-reply-to: <20121109085815.GB13221@visitor2.iram.es>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
 <20121109085815.GB13221@visitor2.iram.es>
Date: Fri, 09 Nov 2012 20:51:07 +1100
Message-ID: <2489.1352454667@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > This set of patches adds support for taking exceptions with the MMU on which is
> > supported by POWER8.
> > 
> > A new set of exception vectors is added at 0xc000_0000_0000_4xxx.  When the HW
> > takes us here, MSR IR/DR will be set already and we no longer need a costly
> > RFID to turn the MMU back on again.
> > 
> > The original 0x0 based exception vectors remain for when the HW can't leave the
> > MMU on.  Examples of this are when we can't trust the current the MMU mappings,
>                                                                 ^^^
> Extra "the" (here and in a couple of patches). 

Thanks, I'll fix.

> Can't do much more since I don't have any hardware past G5, but the
> series looks nice and avoiding transient excursions to real mode is a
> good thing.

Thanks.

Mikey
