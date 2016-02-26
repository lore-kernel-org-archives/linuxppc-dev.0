Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC88E1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:15:06 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 10:15:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 91F03357803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:15:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q0EtIk7471420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:15:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q0EUsk028993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:14:31 +1100
Date: Fri, 26 Feb 2016 11:13:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
Message-ID: <20160226001336.GA18058@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <56C14541.5000302@au1.ibm.com> <20160215233026.GA16298@gwshan>
 <56C2661C.9050707@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C2661C.9050707@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 10:58:20AM +1100, Andrew Donnellan wrote:
>On 16/02/16 10:30, Gavin Shan wrote:
>>Thanks for review. Do you want to see revised patch to include your
>>comments?
>
>Not particularly - the comments were just detailing what I went through as I
>reviewed it. Feel free to include it if you feel it makes the description
>clearer, but I don't really care.
>

I think it's always worthy to have better commit log, v2 will be sent shortly
to have improved commit log, thanks for review.

Thanks,
Gavin

>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
