Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376D31A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 17:15:47 +1000 (AEST)
Received: by yhnv31 with SMTP id v31so46786933yhn.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 00:15:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150618161727.GA6546@lst.de>
References: <20150611095338.GA4492@lst.de>
	<20150618161727.GA6546@lst.de>
Date: Fri, 19 Jun 2015 10:15:44 +0300
Message-ID: <CAOJe8K3B4fEfSpMO3L6WNYxvPfj_rE87dpWZSLY-3EFLOrPyTQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/18/15, Torsten Duwe <duwe@lst.de> wrote:
> Did I miss anything else? I have the notrace optimisations and
> kernel live patching in the queue, which depends on this, so I'd
> really appreciate a comment whether it is acceptable in this form
> or not. Thanks in advance!

Hi Torsten,

could you provide a description how you did test that.

Thanks.
>
> 	Torsten
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
