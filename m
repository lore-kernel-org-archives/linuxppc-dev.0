Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BC331A006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:31:58 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 09:31:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 05E792BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:31:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FNVlv335586264
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:31:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FNVNx1011538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:31:23 +1100
Date: Tue, 16 Feb 2016 10:30:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
Message-ID: <20160215233026.GA16298@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <56C14541.5000302@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C14541.5000302@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 02:25:53PM +1100, Andrew Donnellan wrote:
>On 15/02/16 10:52, Gavin Shan wrote:
>>When eeh_dump_pe_log() is called in eeh_slot_error_detail(), we
>>already have the check that the PE isn't in PCI config blocked
>>state. So we needn't the duplicated check in eeh_dump_pe_log().
>>
>>This removes the duplicated check in eeh_dump_pe_log().
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>eeh_dump_pe_log() isn't called anywhere outside of eeh_slot_error_detail(),
>so this should have no functional change.
>
>Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>

Thanks for review. Do you want to see revised patch to include your
comments?

Thanks,
Gavin

>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
