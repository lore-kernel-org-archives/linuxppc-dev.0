Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2DB71A2ADE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 08:49:10 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 17:49:08 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5E8606E8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 17:40:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NLn5oB29491334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 21:49:06 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NLmnrX013887
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 17:48:49 -0400
Date: Mon, 23 Mar 2015 14:47:56 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [9/9] powerpc/hv-24x7: Add missing put_cpu_var()
Message-ID: <20150323214755.GB23366@us.ibm.com>
References: <1424210434-28070-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317023941.95DDD14010F@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317023941.95DDD14010F@ozlabs.org>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| On Tue, 2015-17-02 at 22:00:34 UTC, Sukadev Bhattiprolu wrote:
| > Add missing put_cpu_var() for 24x7 requests.
| 
| When did it go missing? I assume in upstream, in which case this should be a
| separate patch which I could merge for 4.0.

It went missing in 3.18-rc3 (commit f34b6c7). I will resend this
separately.

Sukadev
