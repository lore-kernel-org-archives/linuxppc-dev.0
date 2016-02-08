Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98F3F1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:57:01 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 8 Feb 2016 15:57:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 588072CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:56:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u185uoSU66977964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 16:56:58 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u185uPhd030570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 16:56:26 +1100
Subject: Re: [PATCH 2/2] powerpc/eeh: Reworked eeh_pe_bus_get()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1454909719-17252-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454909719-17252-2-git-send-email-gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56B82DEE.8000308@au1.ibm.com>
Date: Mon, 8 Feb 2016 16:55:58 +1100
MIME-Version: 1.0
In-Reply-To: <1454909719-17252-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/16 16:35, Gavin Shan wrote:
> The original implementation is ugly: unnecessary if statements and
> "out" tag. This reworks the function to avoid above weaknesses. No
> functional changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

This is definitely a lot nicer to read and doesn't appear to have any 
functional changes.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
