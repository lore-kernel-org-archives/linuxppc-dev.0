Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E90F1A0549
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:18:06 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 908FA14009B
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:18:05 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 18 Feb 2016 11:18:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C231E2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:18:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1I1Hqvp33095796
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:18:00 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1I1HS1S020495
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2016 12:17:28 +1100
Subject: Re: [V2,1/2] powerpc/powernv: new function to access OPAL msglog
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20160217124126.83F60140662@ozlabs.org>
Cc: stewart@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C51B8F.7080602@au1.ibm.com>
Date: Thu, 18 Feb 2016 12:17:03 +1100
MIME-Version: 1.0
In-Reply-To: <20160217124126.83F60140662@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/02/16 23:41, Michael Ellerman wrote:
> I see you've posted a v3 since I merged this, please send an incremental patch
> with the changes.

http://patchwork.ozlabs.org/patch/584416/

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
