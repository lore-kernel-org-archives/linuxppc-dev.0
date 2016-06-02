Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL4Jk1nXSzDr1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:10:30 +1000 (AEST)
Date: Thu, 2 Jun 2016 13:08:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, waiman.long@hpe.com
Subject: Re: [PATCH v5 0/6] powerPC/pSeries use pv-qpsinlock as the default
 spinlock implemention
Message-ID: <20160602110809.GA3190@twins.programming.kicks-ass.net>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160602093350.GY3190@twins.programming.kicks-ass.net>
 <575000C3.2020708@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <575000C3.2020708@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2016 at 05:47:47PM +0800, xinhui wrote:
> 
> 
> On 2016年06月02日 17:33, Peter Zijlstra wrote:
> >
> >
> >I'm thinking one copy a day is quite enough...
> >
> sorry for noise.
> In recent days, our smtp server has some bugs that mails' Message-Id is changed by accident.
> So I resend them just for sure.
> sorry again...

Just don't use corporate email if its not reliable or pain to use; do
not send multiple copies just because.
