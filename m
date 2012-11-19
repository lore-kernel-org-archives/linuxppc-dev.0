Return-Path: <jwboyer@gmail.com>
Received: from mail-vb0-f42.google.com (mail-vb0-f42.google.com
 [209.85.212.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AFB32C00A8
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 00:29:13 +1100 (EST)
Received: by mail-vb0-f42.google.com with SMTP id fs19so755177vbb.15
 for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2012 05:29:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353248997-30763-32-git-send-email-acme@infradead.org>
References: <1353248997-30763-1-git-send-email-acme@infradead.org>
 <1353248997-30763-32-git-send-email-acme@infradead.org>
Date: Mon, 19 Nov 2012 08:29:09 -0500
Message-ID: <CA+5PVA6uj3f5f9Gp=7Zp8CE+0mP7zgCknqmkUX_ootzDxUXRcA@mail.gmail.com>
Subject: Re: [PATCH 31/32] perf powerpc: Use uapi/unistd.h to fix build error
From: Josh Boyer <jwboyer@gmail.com>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 18, 2012 at 9:29 AM, Arnaldo Carvalho de Melo
<acme@infradead.org> wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>
> Use the 'unistd.h' from arch/powerpc/include/uapi to build the perf tool.

This would work for powerpc, but at least s390x and ARM have the same
build issue.  Why would we fix this piecemeal per-arch?

David Howells has a patch that _should_ fix it for all of them at once.
Is there a reason that isn't going in?

josh
