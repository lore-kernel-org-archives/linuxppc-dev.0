Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 792F4DDF64
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 03:07:07 +1100 (EST)
Date: Tue, 3 Feb 2009 17:06:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2] ftrace: On PowerPC we don't need frame pointers for
	CALLER_ADDRs
Message-ID: <20090203160645.GA9020@elte.hu>
References: <20090131190650.GA4284@oksana.dev.rtsoft.ru>
	<1233534919.18767.69.camel@pasglop>
	<1233583455.16878.3.camel@localhost.localdomain>
	<20090203145649.GA19955@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090203145649.GA19955@oksana.dev.rtsoft.ru>
Cc: Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> According to this discussion:
> 
> http://lkml.org/lkml/2008/7/25/338
> http://lkml.org/lkml/2008/7/26/72
> 
> Frame pointers do nothing useful on PowerPC, so lib/Kconfig.debug
> makes CONFIG_FRAME_POINTER unselectable on PPC targets. But ftrace.h
> requires CONFIG_FRAME_POINTER for CALLER_ADDR macros. [...]

hm, why not add PPC to FRAME_POINTERS list of architectures, and select it 
from the powerpc arch Kconfig? Does that cause complications somewhere?

	Ingo
