Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77B2C1A0CBC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:48:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 12 Feb 2015 19:48:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EB3F82CE806D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:48:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C9mDLR33816812
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:48:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C9lms8012515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 20:47:48 +1100
Message-ID: <54DC76B3.4080601@linux.vnet.ibm.com>
Date: Thu, 12 Feb 2015 15:17:31 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] powerpc/powernv: only call OPAL_RESEND_DUMP if
 firmware supports it
References: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1423718729-17992-4-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423718729-17992-4-git-send-email-stewart@linux.vnet.ibm.com>
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
> Not all OPAL platforms support resending system dumps, so check
> that current firmware supports it first. Otherwise we get firmware
> complaining:
> "OPAL: Called with bad token 91 !"
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>


Acked-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant
