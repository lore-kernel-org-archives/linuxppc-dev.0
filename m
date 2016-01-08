Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 813341A02D7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:10:02 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 10 Jan 2016 16:10:00 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AEAE61FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 15:58:07 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0AN9vdL21037116
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 16:09:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0AN9uew005022
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 16:09:56 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Remove misleading comment in pci.c
In-Reply-To: <1452230207-26253-1-git-send-email-ruscur@russell.cc>
References: <1452230207-26253-1-git-send-email-ruscur@russell.cc>
Date: Fri, 08 Jan 2016 17:28:20 +1100
Message-ID: <87oacwfuuz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:
> PCI in powernv now supports quite a bit more than p5ioc2, so remove the
> outdated comment.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
