Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A0F41A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:46:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 12 Feb 2015 19:46:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E29343578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:46:29 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C9kLql34209934
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:46:29 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C9juT0016248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:45:56 +1100
Message-ID: <54DC7643.6020102@linux.vnet.ibm.com>
Date: Thu, 12 Feb 2015 15:15:39 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] powerpc/powernv: only register log if OPAL supports
 doing so
References: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1423718729-17992-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423718729-17992-2-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2015 10:55 AM, Stewart Smith wrote:
> Correct use of REGISTER/UNREGISTER is to check if the token exists
> before calling. If we don't we get a "OPAL: Called with bad token 101 !"
> error, which is harmless but may be alarming to some.
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Acked-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant
