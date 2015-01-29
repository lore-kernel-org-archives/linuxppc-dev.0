Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A0691A0C20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 15:53:08 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 21:53:06 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 02F793E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 21:53:03 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T4r9BL30015512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 21:53:09 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T4r2n6032114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 21:53:02 -0700
Message-ID: <54C9BCA3.2020102@linux.vnet.ibm.com>
Date: Thu, 29 Jan 2015 10:22:51 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
References: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501211243270.5526@nanos>
 <54C09391.9080202@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1501221209260.5526@nanos>
 <54C7068B.3050108@linux.vnet.ibm.com> <54C8B3D2.3070608@linux.vnet.ibm.com>
 <20150128213123.GA27411@localhost.localdomain>
In-Reply-To: <20150128213123.GA27411@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
 Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2015 03:01 AM, Richard Cochran wrote:
> On Wed, Jan 28, 2015 at 03:32:58PM +0530, Preeti U Murthy wrote:
>> Thomas ping. Would you be posting this patch?
> 
> FYI, Thomas is temporarily out of action, in bed with the flu.

Oh I am sorry to hear that! Let me post out a patch based on Thomas's
suggestions around this.

Wishing him a speedy recovery.

Regards
Preeti U Murthy
> 
> Thanks,
> Richard
> 
