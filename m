Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtwLK20hszDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 22:53:13 +1000 (AEST)
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com
 [209.85.216.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A16DD21456
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 12:53:10 +0000 (UTC)
Received: by mail-qt0-f182.google.com with SMTP id f24so2015693qte.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 05:53:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505473476.9665.13.camel@abdul.in.ibm.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Sep 2017 07:52:49 -0500
Message-ID: <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
To: abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mpe <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, sachinp <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2017 at 6:04 AM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> Mainline kernel panics during DLPAR CPU add/remove operation.
>
> Machine Type: Power8 PowerVM LPAR
> kernel 4.13.0

Did 4.12 work or when was it last working? I'm not seeing anything
recent in the DT code that looks suspicious.

Rob
