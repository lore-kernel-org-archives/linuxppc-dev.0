Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06C741A0E29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 16:19:19 +1100 (AEDT)
Message-ID: <1421903958.4598.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/powernv: Skip registering log region
 when CONFIG_PRINTK=n
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 22 Jan 2015 16:19:18 +1100
In-Reply-To: <1421893570-6920-2-git-send-email-bobby.prani@gmail.com>
References: <1421893570-6920-1-git-send-email-bobby.prani@gmail.com>
 <1421893570-6920-2-git-send-email-bobby.prani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, "open
 list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 21:26 -0500, Pranith Kumar wrote:
> When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
> return 0. Check for these return values and skip registering the dump buffer.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 6 ++++++
>  1 file changed, 6 insertions(+)

What changed since v1? I don't see anything?

cheers
