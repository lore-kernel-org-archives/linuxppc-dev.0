Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvblD3RwMzF07t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 08:29:12 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id n24so1896990ual.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 13:29:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
References: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Mar 2018 08:29:09 +1100
Message-ID: <CAKTCnzmdB3g0Kh67Lo7HQUp=-qRROaq_3hh8dLnDdSan3guFYw@mail.gmail.com>
Subject: Re: [PATCH v2] xmon: Setup xmon debugger hooks when first break-point
 is set
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 5, 2018 at 4:30 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line. However this
> doesn't enable the kernel debugger hooks needed for instruction or data
> breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
> of the form below is reported:
>
> Oops: Exception in kernel mode, sig: 5 [#1]
> < snip >
> Trace/breakpoint trap
>
> To fix this the patch checks and enables debugger hooks when an
> instruction or data break-point is set via xmon console.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
