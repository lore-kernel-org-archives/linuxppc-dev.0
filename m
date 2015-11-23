Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E88BE1A029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 16:49:59 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 11:19:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6D2CE125805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:20:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAN5nsZC2752860
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:19:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAN5nr72000977
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:19:54 +0530
Message-ID: <5652A900.5000404@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 11:19:52 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove unused function trace_syscall()
References: <1447903588-610-1-git-send-email-rashmicy@gmail.com>
 <564D4342.6050400@au1.ibm.com>
In-Reply-To: <564D4342.6050400@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2015 09:04 AM, Andrew Donnellan wrote:
> On 19/11/15 14:26, Rashmica Gupta wrote:
>> This function has been unused since commit 14cf11af6cf6 ("powerpc:
>> Merge enough
>> to start building in arch/powerpc."), so remove it.
>>
>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> 
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
