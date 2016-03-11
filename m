Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BC2A1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 12:50:02 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14F4814017E
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 12:50:01 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 11 Mar 2016 11:50:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3B1083578052
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 12:49:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2B1njPw1245642
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 12:49:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2B1nKu5009321
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 12:49:20 +1100
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
To: Ian Munsie <imunsie@au1.ibm.com>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
 <1457570763-sup-7740@delenn.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <michaele@au1.ibm.com>, Matt Ochs <mrochs@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Manoj Kumar <kumarmn@us.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56E22407.6080609@au1.ibm.com>
Date: Fri, 11 Mar 2016 12:48:55 +1100
MIME-Version: 1.0
In-Reply-To: <1457570763-sup-7740@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/16 12:18, Ian Munsie wrote:
> On a related matter, we should send a patch to remove some of the
> leftover config options that were added to smooth the merging of
> cxlflash in the first place (CXL_KERNEL_API, CXL_EEH).

I'm happy to do that after this series is merged.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
