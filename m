Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCNP544BxzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 09:52:57 +1100 (AEDT)
Received: by mail-oi0-x232.google.com with SMTP id g6so2036661oib.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 14:52:57 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180104224542.15333-3-robh@kernel.org>
References: <20180104224542.15333-3-robh@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 4 Jan 2018 23:52:54 +0100
Message-ID: <CAK8P3a2COeOQDRXmu+bqA-a5pH7LWxm7PfKn9UDsBWZ2EJzg4w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: cell: use irq_of_parse_and_map helper
To: Rob Herring <robh@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 4, 2018 at 11:45 PM, Rob Herring <robh@kernel.org> wrote:
> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
> of_irq_parse_and_map instead which does the same thing. This gets us closer
> to making the former 2 functions static.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
