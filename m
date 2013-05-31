Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 8AB642C02AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:13:56 +1000 (EST)
Date: Thu, 30 May 2013 22:14:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
Message-ID: <20130531051423.GA15505@roeck-us.net>
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
 <51A5CAC1.6030800@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51A5CAC1.6030800@freescale.com>
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 29, 2013 at 05:30:41PM +0800, Chen Yuanquan-B41889 wrote:
> On 05/29/2013 01:35 AM, Guenter Roeck wrote:
> >bios_add_device(). Drop explicit calls to pcibios_setup_device();
> >this makes pcibios_setup_bus_devices() a noop function which could
> >eve
> 
> Yeah, it's more reasonable to do the irq and DMA related initialization
> in one code path for all devices.
> 
Any comments / feedback on the code itself ?

Thanks,
Guenter
