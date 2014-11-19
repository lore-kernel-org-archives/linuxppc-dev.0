Return-Path: <joel.stan@gmail.com>
Received: from mail-vc0-x233.google.com (mail-vc0-x233.google.com
 [IPv6:2607:f8b0:400c:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A5181A09BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 13:34:49 +1100 (AEDT)
Received: by mail-vc0-f179.google.com with SMTP id le20so7875366vcb.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 18:34:47 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20141118065603.22544.88816.stgit@preeti.in.ibm.com>
References: <20141118065603.22544.88816.stgit@preeti.in.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Nov 2014 13:04:27 +1030
Message-ID: <CACPK8Xc7G6JgqPYUmGTx8O=a6jxMB0yf1weEraMBu8dcAJibuQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle/powernv: Re-enable fastsleep at boot time
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rjw@rjwysocki.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Preeti,

On Tue, Nov 18, 2014 at 5:26 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> Commit dcb18694 "Fix ipi on palmeto" disabled fastsleep at boot time.

I couldn't find this commit in any tree; upstream, mpe's next, nor powerkvm.

I remember testing this as a workaround for the palmetto, but I don't
recall sending it upstream.

Cheers,

Joel
