Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkP1w4jstzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 20:53:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pcmcia@lists.infradead.org, linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qiang.zhao@nxp.com,
 claudiu.manoil@nxp.com
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
In-Reply-To: <1489600245.2944.19.camel@buserror.net>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
 <87wpbsuo4x.fsf@concordia.ellerman.id.au>
 <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
 <8760jbump6.fsf@concordia.ellerman.id.au>
 <1489600245.2944.19.camel@buserror.net>
Date: Thu, 16 Mar 2017 20:53:49 +1100
Message-ID: <87a88llf82.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:
> On Wed, 2017-03-15 at 16:35 +1100, Michael Ellerman wrote:
>> I'll do patches for everything above that's not drivers/soc or
>> include/soc and hopefully we can hear from someone at NXP on the plans
>> for getting the soc parts enabled on arm.
>
> qe_ic is handled by=C2=A0https://lkml.org/lkml/2017/3/13/1234

Thanks.

cheers
