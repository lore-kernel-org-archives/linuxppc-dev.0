Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED661A0368
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 11:53:45 +1100 (AEDT)
Message-ID: <1446425625.27828.0.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <frederic.barrat@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Mon, 02 Nov 2015 11:53:45 +1100
In-Reply-To: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-29 at 13:39 +0100, Frederic Barrat wrote:

> When the cxl driver creates a context, it stores the pid of the
> calling task, incrementing the reference count on the struct
> pid. Current code mistakenly increments the reference count twice,
> once through get_task_pid(), once through get_pid(). The reference
> count is only decremented once on detach, thus the struct pid of the
> task attaching is never freed. The fix is to simply remove the call to
> get_pid().
> 
> Signed-off-by: Frederic Barrat <frederic.barrat@fr.ibm.com>

What's the symptom?
Broken since when?
Forever?
So should go to stable?
Starting from which release?

cheers
