Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FFDF1A040D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 22:28:28 +1100 (AEDT)
Message-ID: <54537254.5050401@linutronix.de>
Date: Fri, 31 Oct 2014 12:28:20 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Johannes Thumshirn <johannes.thumshirn@men.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: FSL MSI Mapping
References: <20141028170604.GA1536@jtlinux>
 <1414641117.12600.4.camel@concordia> <20141031081225.GA20831@jtlinux>
In-Reply-To: <20141031081225.GA20831@jtlinux>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, 'David Engster' <david.engster@mahr.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2014 09:12 AM, Johannes Thumshirn wrote:
> On Thu, Oct 30, 2014 at 02:51:57PM +1100, Michael Ellerman wrote:
>> Why would you not use MSI-X ?

If I'm not mistaken, a PCI-E requirement is to support MSI but MSI-X is
optional. And with MSI you can have multiple interrupts per single
device (power of two, max 32).
Now imagine you have a FPGA with two (or more) different devices in it
and you don't want them to share the IRQ line (for $reason). I bet the
HW developer sees MSI and MSI-X and the former is for some reason
cheaper compared to MSI-X and it fits the needs. So…

> 
> Does anyone (especially the original author) have any objections if I re-spin
> the patch series?

I didn't get around to address the review comments so it did not went
in and there was no v2. Feel free re-do the series.

Sebastian
