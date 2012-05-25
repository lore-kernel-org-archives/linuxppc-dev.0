Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7F8D9B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 13:38:52 +1000 (EST)
Message-ID: <1337917105.16119.11.camel@pasglop>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 May 2012 13:38:25 +1000
In-Reply-To: <CAErSpo6W28r4f5pJmZr=ofUAaffiUtOqgXWeabGpr+DmKw+Z+g@mail.gmail.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
 <1337914811.16119.7.camel@pasglop>
 <CAErSpo6W28r4f5pJmZr=ofUAaffiUtOqgXWeabGpr+DmKw+Z+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michal Simek <monstr@monstr.eu>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
 microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-24 at 21:08 -0600, Bjorn Helgaas wrote:
> 
> OK.  Are you worried about cardbus in particular?
> 
> This is headed for the 3.6, not 3.5, so we should have plenty of time.
>  As soon as everything for the current merge window gets merged and
> -next is ready for the next batch, I'll put this in there.

I'm not that worried about cardbus ... in fact I wouldn't be surprised
if it's already somewhat broken, I haven't tested it in a long time...

I'm more worried about basic functionality and expectations about when
things happen during boot vs. platform hacks, that and pseries specific
kind of hotplug which can be a bit odd.

Cheers,
Ben.
