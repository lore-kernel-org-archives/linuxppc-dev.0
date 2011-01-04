Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 6AC21B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 09:03:54 +1100 (EST)
In-Reply-To: <20110104152018.080ff075@udp111988uds.am.freescale.net>
References: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>	<20110104132317.006ead39@udp111988uds.am.freescale.net>
	<OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
	<20110104152018.080ff075@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: Question about combining a PCI driver with an OF driver
Message-ID: <OF6CCC9C4D.D8F6E7A5-ON8825780E.0079088C-8825780E.00793405@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 4 Jan 2011 14:03:51 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> > Okay, I get that and it makes sense with what I know so far about how 
the 
> > kernel device model works (which I'm still learning).  So how would I 
> > manually add a device?  Say I create the PCI wrapper driver that 
claims 
> > the clone-TSEC, is there a "register device" type call similar to 
> > pci_register_driver() that I could put in the wrapper code that causes 
the 
> > gfar_probe() to be called?
> 
> Create an OF node (probably under the root node) programatically with
> all the information the gianfar driver will want, based on what you
> detect on PCI, and call of_platform_device_create().
> 

Ah, the light bulb clicks on!  Thanks for the info.  I appreciate it.

Bruce
