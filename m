Return-Path: <srs0=banz=7q=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW4pz0c97zDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 16:05:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xW4py6qfpz8t59
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 16:05:46 +1000 (AEST)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xW4py31g0z9t3f
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 16:05:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u185so8987703pgb.0
 for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2017 23:05:45 -0700 (PDT)
Date: Mon, 14 Aug 2017 16:05:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, mikey@neuling.org, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/17] powerpc/vas: Define macros, register fields
 and structures
Message-ID: <20170814160522.4f9b517a@roar.ozlabs.ibm.com>
In-Reply-To: <877ey6sp03.fsf@concordia.ellerman.id.au>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <877ey6sp03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Aug 2017 15:21:48 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> >  arch/powerpc/include/asm/vas.h       |  35 ++++
> >  arch/powerpc/include/uapi/asm/vas.h  |  25 +++  
> 
> I thought we weren't exposing VAS to userspace yet?
> 
> If we are then we need to get things straight WRT copy/paste abort.

No we should not be. This might be just a leftover hunk that should
be moved to a future series.

At the moment (as far as I understand) it should be limited to
preempt-disabled, process context, kernel users which avoids any
concern for switch_to.

Thanks,
Nick
