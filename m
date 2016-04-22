Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrx5m3XJGzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:52 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 23:18:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3BD4C2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:41 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDIXrX21233800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDI8TL016843
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:08 +1000
Date: Fri, 22 Apr 2016 23:17:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 alistair@popple.id.au, david@gibson.dropbear.id.au, mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] powerpc/eeh: Drop unnecessary label in
 eeh_pe_change_owner()
Message-ID: <20160422131745.GB31375@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461239595-5627-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461307125.2646.5.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1461307125.2646.5.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2016 at 04:38:45PM +1000, Russell Currey wrote:
>On Thu, 2016-04-21 at 21:53 +1000, Gavin Shan wrote:
>> The label "reset" in eeh_pe_change_owner() is used only for once.
>> No need to keep it and just drop it. No logicial changes introduced.
>
>"logicial" should be "logical". =A0I found something to be pedantic abou=
t on each
>patch! :)

Thanks, Russell. I'll fix in next revision ;-)

>>=20
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>
>Reviewed-by: Russell Currey <ruscur@russell.cc>
>
