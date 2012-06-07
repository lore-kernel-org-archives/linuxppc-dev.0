Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 961B0B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 07:32:06 +1000 (EST)
Message-ID: <1339104711.24838.29.camel@pasglop>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Date: Fri, 08 Jun 2012 07:31:51 +1000
In-Reply-To: <4FD0A257.4070506@jp.fujitsu.com>
References: <4FBC4C86.9050206@jp.fujitsu.com>
 <1338960416.7150.160.camel@pasglop> <4FD0A257.4070506@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-07 at 21:45 +0900, Hiroo Matsumoto wrote:
> 
> > Also you seem to add:
> > 
> > +               /* Setup OF node pointer in the device */
> > +               dev->dev.of_node = pci_device_to_OF_node(dev);
> > 
> > This shouldn't be needed anymore, the device node should be setup by the
> > core nowadays. Is this just a remnant of you rebasing an old patch or do
> > you have a good reason to add this statement ?
> 
> No, I don't have a good reason to add this statement.
> I just tried to make this code be same with pcibios_setup_bus_devices.
> Thanks for your review and comment. 

Unless I'm mistaken, this statement was removed from
pcibios_setup_bus_devices() recently so I'd say it's a leftover from
your patch having been originally done on top of an older kernel.

I won't be back for another week or so but I'll see if I can get things
tested in the meantime.

Cheers,
Ben.
