Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B58F1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 20:58:04 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF41D14033B
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 20:58:03 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 19:58:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6730C3578058
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 20:57:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u219vmj412059030
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 20:57:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u219vNDL019302
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 20:57:24 +1100
Date: Tue, 1 Mar 2016 15:26:39 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH v2 1/8] powerpc: Create a helper for getting the kernel
 toc value
Message-ID: <20160301095637.GA13436@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-02-29 20:26:22]:

> Move the logic to work out the kernel toc pointer into a header. This is
> a good cleanup, and also means we can use it elsewhere in future.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
