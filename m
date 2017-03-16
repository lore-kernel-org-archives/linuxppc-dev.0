Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkP3q52RwzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 20:55:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pcmcia@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oss@buserror.net,
 linuxppc-dev@ozlabs.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
 qiang.zhao@nxp.com
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
In-Reply-To: <CAK8P3a2TzAdOnyOyS5ZbQK5WRkNKnGxLc=7SYjw_Y75VdbnyZw@mail.gmail.com>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
 <87wpbsuo4x.fsf@concordia.ellerman.id.au>
 <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
 <8760jbump6.fsf@concordia.ellerman.id.au>
 <CAK8P3a2TzAdOnyOyS5ZbQK5WRkNKnGxLc=7SYjw_Y75VdbnyZw@mail.gmail.com>
Date: Thu, 16 Mar 2017 20:55:32 +1100
Message-ID: <877f3plf57.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Mar 15, 2017 at 6:35 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> I'll do patches for everything above that's not drivers/soc or
>> include/soc and hopefully we can hear from someone at NXP on the plans
>> for getting the soc parts enabled on arm.
>
> I think the removal of the NO_IRQ references is a requirement for
> getting the drivers working properly on ARM, as the OF platform
> code will use '0' for invalid IRQs.

OK. So the #define NO_IRQ (-1) in arch/arm/include/asm/irq.h is a red
herring and should be ignored for anything modern?

cheers
