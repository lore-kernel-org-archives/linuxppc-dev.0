Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 646371A0902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:55:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 20:54:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9517E2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:54:55 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1BAsk8F37814450
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:54:55 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1BAsKo6008173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:54:21 +1100
Message-ID: <54DB34C4.4080306@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 16:23:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH v2 1/2] opal: Fix the overflow of message notifiers head
 array
References: <20150211062616.3279.71632.stgit@localhost.localdomain>
In-Reply-To: <20150211062616.3279.71632.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2015 11:57 AM, Neelesh Gupta wrote:
> Fixes the condition check of incoming message type which can
> otherwise shoot beyond the message notifiers head array.
> 
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
