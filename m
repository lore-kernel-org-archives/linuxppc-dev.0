Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AC292C0314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 12:18:20 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 03:18:17 +0100
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id F0FAB38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:18:12 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S2IDM952297950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:18:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S2ICLp015102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 22:18:13 -0400
Date: Fri, 28 Jun 2013 10:18:09 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/eeh: Update MAINTAINERS
Message-ID: <20130628021808.GA22882@shangw.(null)>
References: <1372384784-20788-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372385489.18612.52.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372385489.18612.52.camel@pasglop>
Cc: Linas Vepstas <linasvepstas@gmail.com>, linuxppc-dev@lists.ozlabs.org,
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

On Fri, Jun 28, 2013 at 12:11:29PM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2013-06-28 at 09:59 +0800, Gavin Shan wrote:
>> Update MAINTAINERS to reflect recent changes.
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  MAINTAINERS |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5be702c..b447392 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6146,10 +6146,14 @@ F:	drivers/firmware/pcdp.*
>>  
>>  PCI ERROR RECOVERY
>>  M:	 
>> +M:	Gavin Shan <shangw@linux.vnet.ibm.com>
>
>Remove Linas, he isn't involved anymore as far as I can tell
>(are you ?)
>
>>  L:	linux-pci@vger.kernel.org
>> +L:	linuxppc-dev@lists.ozlabs.org
>>  S:	Supported
>>  F:	Documentation/PCI/pci-error-recovery.txt
>>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>> +F:	arch/powerpc/kernel/eeh*.c
>> +F:	drivers/pci/pcie/aer/
>
>Not sure about the AER code. You are not maintaining *that* at least :-)
>Maybe we should split EEH from the rest ?
>

Ok. Split EEH from it and keep everything for "PCI ERROR RECOVERY".

Thanks,
Gavin
