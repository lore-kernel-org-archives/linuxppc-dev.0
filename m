Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 986132C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 15:12:56 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 6 May 2013 23:12:54 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BD3FB3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 23:12:36 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r475CpAx094250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 23:12:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r475CofK022959
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 23:12:51 -0600
Date: Tue, 7 May 2013 13:12:46 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/powernv: Don't configure IO window on PHB3
Message-ID: <20130507051246.GB31911@shangw.(null)>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1367876070.15842.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367876070.15842.60.camel@pasglop>
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 07, 2013 at 07:34:30AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2013-05-06 at 21:44 +0800, Gavin Shan wrote:
>> We needn't configure IO windows for the corresponding PEs on PHB3
>> since that doesn't support IO.
>
>Here too, no need for such a flag, just check that
>pci_controller->io_resource.flags is 0.
>
>BTW. Please work on top of the patch I sent already that avoids adding
>bogus resources to pci_host_bridge when their flags are 0. I'll send
>it to Linus today.
>

I've changed it accordingly on top of your patches in v2 :-)

Thanks,
Gavin
