Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x22d.google.com (mail-vc0-x22d.google.com
 [IPv6:2607:f8b0:400c:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02C921A0E7E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 01:35:11 +1100 (AEDT)
Received: by mail-vc0-f173.google.com with SMTP id id10so579468vcb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 06:35:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1421903958.4598.4.camel@ellerman.id.au>
References: <1421893570-6920-1-git-send-email-bobby.prani@gmail.com>
 <1421893570-6920-2-git-send-email-bobby.prani@gmail.com>
 <1421903958.4598.4.camel@ellerman.id.au>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 22 Jan 2015 09:34:37 -0500
Message-ID: <CAJhHMCDPCdeGSfGFoYcUHXQoemtmSTdsmLrS3_GOewrvNQm8kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/powernv: Skip registering log region when
 CONFIG_PRINTK=n
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2015 at 12:19 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-01-21 at 21:26 -0500, Pranith Kumar wrote:
>> When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
>> return 0. Check for these return values and skip registering the dump buffer.
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/platforms/powernv/opal.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> What changed since v1? I don't see anything?
>

Nothing in this patch but there is a v2 of the first patch in this
series, so had to resend this patch with a v2.

Thanks!
-- 
Pranith
