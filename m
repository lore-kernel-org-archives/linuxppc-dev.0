Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C96A92C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:44:21 +1000 (EST)
Message-ID: <1369979047.3928.112.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 May 2013 15:44:07 +1000
In-Reply-To: <20130531051423.GA15505@roeck-us.net>
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
 <51A5CAC1.6030800@freescale.com> <20130531051423.GA15505@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Chen Yuanquan-B41889 <B41889@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 22:14 -0700, Guenter Roeck wrote:
> On Wed, May 29, 2013 at 05:30:41PM +0800, Chen Yuanquan-B41889 wrote:
> > On 05/29/2013 01:35 AM, Guenter Roeck wrote:
> > >bios_add_device(). Drop explicit calls to pcibios_setup_device();
> > >this makes pcibios_setup_bus_devices() a noop function which could
> > >eve
> > 
> > Yeah, it's more reasonable to do the irq and DMA related initialization
> > in one code path for all devices.
> > 
> Any comments / feedback on the code itself ?

Sorry, I haven't had a chance to review it yet, I'm fairly bogged down
at the moment. I want to tread carefully because the previous iteration
of changing that stuff did break a few platforms in the end.

Cheers,
Ben.
