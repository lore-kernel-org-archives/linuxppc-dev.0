Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDB8F1A1F42
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 10:23:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 7 Sep 2015 10:23:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 88E742CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 10:23:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t870N3Mu25886750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 10:23:11 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t870MgjA017886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 10:22:42 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t870Mg18017584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 10:22:42 +1000
Received: from [10.61.2.248] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0B14FA01A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 10:22:18 +1000 (AEST)
Message-ID: <55ECD8C7.8040600@au1.ibm.com>
Date: Mon, 07 Sep 2015 10:22:31 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: abort cxl_pci_enable_device_hook() if PCI channel
 is offline
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1441583849-sup-2488@delenn.ozlabs.ibm.com>
In-Reply-To: <1441583849-sup-2488@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/09/15 09:58, Ian Munsie wrote:
> Excerpts from andrew.donnellan's message of 2015-09-04 16:20:24 +1000:
>> +    if (!cxl_adapter_link_ok(afu->adapter))
>> +        dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
>> +        return false;
>
> Based on the indentation it looks like you meant to add some curly
> brackets here.

Indeed I did, and I'd even thought I'd tested it... this is why I 
shouldn't be allowed to submit patches at 4pm on Fridays...

Will submit V2.

(FWIW, I'm a firm believer in braces around single statements in 
conditionals to avoid mistakes like this, but CodingStyle disagrees...)


Andrew


-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
