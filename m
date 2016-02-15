Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 878BE1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 14:26:53 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 15 Feb 2016 13:26:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8AC563578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 14:26:50 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F3QgHn59506830
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 14:26:50 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F3QIgV011639
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 14:26:18 +1100
Subject: Re: [PATCH] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C14541.5000302@au1.ibm.com>
Date: Mon, 15 Feb 2016 14:25:53 +1100
MIME-Version: 1.0
In-Reply-To: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/02/16 10:52, Gavin Shan wrote:
> When eeh_dump_pe_log() is called in eeh_slot_error_detail(), we
> already have the check that the PE isn't in PCI config blocked
> state. So we needn't the duplicated check in eeh_dump_pe_log().
>
> This removes the duplicated check in eeh_dump_pe_log().
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

eeh_dump_pe_log() isn't called anywhere outside of 
eeh_slot_error_detail(), so this should have no functional change.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
