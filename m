Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D0E3B6EF3
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 13:01:20 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 23:01:18 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C6F2938C8052
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 23:01:15 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5Q31FVt150568
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 23:01:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5Q31ELA013609
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 00:01:15 -0300
Date: Tue, 26 Jun 2012 11:01:11 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
Message-ID: <20120626030111.GA6753@shangw>
References: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
 <CAE9FiQUE0_niTRmvZ=ROSFKB4HKDFFLjfJC+QeQkTKLMyvxv4g@mail.gmail.com>
 <20120626003020.GA6307@shangw> <1340679045.3732.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340679045.3732.3.camel@pasglop>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>, Gavin Shan <shangw@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> >> +EXPORT_SYMBOL(pci_bus_host_bridge);
>> 
>> Yinghai, thanks for your time on this :-)
>> 
>> >
>> >why do you need to export it?
>> >
>> 
>> The reason is that we have introduced extra fields to "struct
>> pci_host_bridge"
>> in [PATCH 2/2] and platform want to access those extra fields. 
>
>But the platform code is built-in, not modular, so it doesn't need
>EXPORT_SYMBOL (additionally even if we wanted to export it we probably
>also want it _GPL only, so EXPORT_SYMBOL_GPL, but I don't think we need
>to).
>

Ben, thanks for correcting me :-)

Let me remove EXPORT_SYMBOL() is next revision.

>Cheers,
>Ben.
>
>

Thanks,
Gavin
