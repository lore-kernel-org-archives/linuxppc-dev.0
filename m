Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E217E2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 11:00:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Jun 2013 21:00:09 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DCAE9C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 21:00:05 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r531067v36110456
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:00:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r53104XU021923
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:00:06 -0400
Date: Mon, 3 Jun 2013 09:00:02 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/23] powerpc/eeh: Function to tranverse PCI devices
Message-ID: <20130603010002.GA7316@shangw.(null)>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1370059983.3766.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370059983.3766.1.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 01, 2013 at 02:13:03PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
>> For EEH on PowerNV platform, the PCI devices will be probed to
>> check if they support EEH functionality. Different from the case
>> of EEH for pSeries platform, we will probe real PCI device instead
>> of device tree node for EEH capability on PowerNV platform.
>> 
>> The patch introduces function eeh_pci_dev_traverse() to traverse
>> PCI devices for the indicated PCI bus from top to bottom.
>
>This seems racy vs. hotplug etc... Any reason you can't use
>pci_walk_bus() from drivers/pci/bus.c ?
>

Thanks, Ben. I'll use pci_walk_bus() in next version.

Thanks,
Gavin
