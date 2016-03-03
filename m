Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 470DF1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 17:48:37 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14C9D140DF7
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2016 17:48:37 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 3 Mar 2016 16:48:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E299C2CE805A
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2016 17:48:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u236mNiF4587876
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Mar 2016 17:48:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u236lxJD032009
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Mar 2016 17:47:59 +1100
Date: Thu, 3 Mar 2016 12:17:37 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v3 1/8] powerpc: Create a helper for getting the kernel
 toc value
Message-ID: <20160303064736.GA18743@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-03-03 15:26:53]:

> Move the logic to work out the kernel toc pointer into a header. This is
> a good cleanup, and also means we can use it elsewhere in future.
> 
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

For the patchset,

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
