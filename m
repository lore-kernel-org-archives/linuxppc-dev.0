Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7595B1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:59:19 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 16 Feb 2016 09:59:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 171CD2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:59:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FNx9gx8978874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:59:17 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FNwipr032739
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:58:44 +1100
Subject: Re: [PATCH] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <56C14541.5000302@au1.ibm.com> <20160215233026.GA16298@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C2661C.9050707@au1.ibm.com>
Date: Tue, 16 Feb 2016 10:58:20 +1100
MIME-Version: 1.0
In-Reply-To: <20160215233026.GA16298@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/16 10:30, Gavin Shan wrote:
> Thanks for review. Do you want to see revised patch to include your
> comments?

Not particularly - the comments were just detailing what I went through 
as I reviewed it. Feel free to include it if you feel it makes the 
description clearer, but I don't really care.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
