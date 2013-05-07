Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D14D22C0143
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 15:12:12 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 6 May 2013 23:12:10 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4B3DD19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 23:11:57 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r475C3ad123414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 23:12:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r475C2oe028253
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 23:12:03 -0600
Date: Tue, 7 May 2013 13:11:57 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/powernv: Disable IO space for PCI buses
Message-ID: <20130507051157.GA31911@shangw.(null)>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1367847858-6506-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1367875982.15842.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367875982.15842.58.camel@pasglop>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 07, 2013 at 07:33:02AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2013-05-06 at 21:44 +0800, Gavin Shan wrote:
>> The patch intends to set the special flag (PCI_BUS_FLAGS_NO_IO) for
>> root buses so PCI core will skip assignment for IO stuff. Besides,
>> we also clear the IO resources on all PCI devices for PHB3.
>
>Why the new hook ? Can't this be detected simply because there is
>no aperture in the pci_host_bridge with IORESOURCE_IO set in the flags ?
>

Yeah, Ben. I've changed it accordingly in v2 and the problem is that we
need the proposed patches from Yinghai or mine :-)

Thanks,
Gavin 
