Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914531A0E52
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 09:35:40 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 17:35:38 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0BD716E8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:27:28 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0MMZZuZ26804454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 22:35:35 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0MMZYvP029586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:35:34 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/powernv: Skip registering log region when
 CONFIG_PRINTK=n
In-Reply-To: <CAJhHMCDPCdeGSfGFoYcUHXQoemtmSTdsmLrS3_GOewrvNQm8kA@mail.gmail.com>
References: <1421893570-6920-1-git-send-email-bobby.prani@gmail.com>
 <1421893570-6920-2-git-send-email-bobby.prani@gmail.com>
 <1421903958.4598.4.camel@ellerman.id.au>
 <CAJhHMCDPCdeGSfGFoYcUHXQoemtmSTdsmLrS3_GOewrvNQm8kA@mail.gmail.com>
Date: Fri, 23 Jan 2015 09:35:28 +1100
Message-ID: <m3sif2zbnz.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh@kernel.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 open list <linux-kernel@vger.kernel.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
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

Pranith Kumar <bobby.prani@gmail.com> writes:
> On Thu, Jan 22, 2015 at 12:19 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On Wed, 2015-01-21 at 21:26 -0500, Pranith Kumar wrote:
>>> When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
>>> return 0. Check for these return values and skip registering the dump buffer.
>>>
>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>> CC: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>  arch/powerpc/platforms/powernv/opal.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>
>> What changed since v1? I don't see anything?
>>
>
> Nothing in this patch but there is a v2 of the first patch in this
> series, so had to resend this patch with a v2.

You also missed my Reviewed-by :)
