Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpQZW1pWmzDqwQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 12:16:51 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id ks6so1124213pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 19:16:51 -0700 (PDT)
Date: Tue, 12 Jul 2016 01:39:13 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>,
 "cyrilbur@gmail.com" <cyrilbur@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
Message-ID: <20160711173913.GA24401@simonLocalRHEL7.x64>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
 <1467898167.27157.47.camel@kernel.crashing.org>
 <577f7a45.568f6b0a.bd0eb.4aa8SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <577f7a45.568f6b0a.bd0eb.4aa8SMTPIN_ADDED_BROKEN@mx.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2016 at 08:02:42PM +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Thu, 2016-07-07 at 23:21 +1000, Benjamin Herrenschmidt wrote:
> >> 
> >> I think the right fix is that if a restore_sigcontext() has the MSR
> >> bits set,
> >> it should set the corresponding used_* flag.
> >
> > Something like this:
> >
> > (totally untested)
> 
> Simon/Laurent, can you guys test this and let me know if it works for
> your usecase.

Just notice this note.
Yes I will test it on CRIU and update later.

Thanks,
- Simon
