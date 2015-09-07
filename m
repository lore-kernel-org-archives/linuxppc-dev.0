Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDC041A2350
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 14:00:53 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91F2B14056B
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 14:00:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 7 Sep 2015 14:00:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB5342BB004D
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 14:00:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8740WAE46792830
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 14:00:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8740FtT016540
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 14:00:16 +1000
Message-ID: <55ED0BC5.3000908@au1.ibm.com>
Date: Mon, 07 Sep 2015 14:00:05 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au1.ibm.com,
 dja@axtens.net
Subject: Re: [PATCH v2] cxl: abort cxl_pci_enable_device_hook() if PCI channel
 is offline
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>	
 <1441587178-5581-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1441594391.12945.2.camel@ellerman.id.au>
In-Reply-To: <1441594391.12945.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/15 12:53, Michael Ellerman wrote:
> Is this a fix targetting 4.3 (current release) and/or stable, or something for
> next?

4.3 - this fix is related to cxl's EEH support which has been merged for 
4.3.

For the record, since I neglected to add this earlier:

---
Changes from v1:
- Insert braces so that "return false" is within if block


-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
