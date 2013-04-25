Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41E682C0109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:48:09 +1000 (EST)
Message-ID: <1366879678.2869.25.camel@pasglop>
Subject: Re: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 18:47:58 +1000
In-Reply-To: <20130425081333.GA10637@shangw.(null)>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1366836580.2869.16.camel@pasglop> <20130425080836.GA27415@shangw.(null)>
 <20130425081333.GA10637@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-25 at 16:13 +0800, Gavin Shan wrote:
> It should be "chip_data" (not "irq_data"). Hopefully, you haven't
> get time to see the reply. Otherwise, it would a bit confused ;-)

Doesn't ics-opal already use chip_data ?

I was thinking just duplicating the irq_chip (including chip_data) so it
can be used by ics-opal just fine for all calls, just then overriding
the eoi callback and using container_of to get to the PHB.

Any reason that wouldn't work ?

Cheers,
Ben.
