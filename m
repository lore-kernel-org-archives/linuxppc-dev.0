Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x235.google.com (mail-vc0-x235.google.com
 [IPv6:2607:f8b0:400c:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 105BF1A0EB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:04:07 +1100 (AEDT)
Received: by mail-vc0-f181.google.com with SMTP id id10so1847390vcb.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 20:04:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m3sif2zbnz.fsf@oc8180480414.ibm.com>
References: <1421893570-6920-1-git-send-email-bobby.prani@gmail.com>
 <1421893570-6920-2-git-send-email-bobby.prani@gmail.com>
 <1421903958.4598.4.camel@ellerman.id.au>
 <CAJhHMCDPCdeGSfGFoYcUHXQoemtmSTdsmLrS3_GOewrvNQm8kA@mail.gmail.com>
 <m3sif2zbnz.fsf@oc8180480414.ibm.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 22 Jan 2015 23:03:34 -0500
Message-ID: <CAJhHMCB+5Qkyfpkvrgi5+DVyc2O3HJ1VVmBXEs_ETw1rst0OZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/powernv: Skip registering log region when
 CONFIG_PRINTK=n
To: Stewart Smith <stewart@linux.vnet.ibm.com>
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

On Thu, Jan 22, 2015 at 5:35 PM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> Pranith Kumar <bobby.prani@gmail.com> writes:
>> On Thu, Jan 22, 2015 at 12:19 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> On Wed, 2015-01-21 at 21:26 -0500, Pranith Kumar wrote:
>>>> When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
>>>> return 0. Check for these return values and skip registering the dump buffer.
>>>>
>>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>>> CC: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>  arch/powerpc/platforms/powernv/opal.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>
>>> What changed since v1? I don't see anything?
>>>
>>
>> Nothing in this patch but there is a v2 of the first patch in this
>> series, so had to resend this patch with a v2.
>
> You also missed my Reviewed-by :)
>

Sincere apologies for the oversight. Maintainers, could you please add
this Reviewed-by tag when picking this up?

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Thanks!

-- 
Pranith
