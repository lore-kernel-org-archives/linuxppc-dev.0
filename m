To: Ruedi Hofer <ruedi.hofer@ascom.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860
References: <38E9BA8F.913681C7@ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 04 Apr 2000 13:54:47 +0200
In-Reply-To: Ruedi Hofer's message of "Tue, 04 Apr 2000 11:49:03 +0200"
Message-ID: <kfyhfdiw06w.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi Hofer <ruedi.hofer@ascom.ch> writes:

Hi,

> I patched the files mpc8xx.h and init.c as you wrote. Then I recompiled the
> kernel (2.2.13, including fpu, damm, bossek patches) and restarted it.
> Then I used the rc.pcmcia to set the modules up. It fails because of...
>
> sh-2.03# ./rc.pcmcia start
> Starting PCMCIA services: modules/lib/modules/2.2.13/pcmcia/pcmcia_core.o:
> unresolved symbol request_8xxirq

[snip]

> Does someone have a clue on that? Is request_irq and request_8xxirq related??

Just stuff an:

EXPORT_SYMBOL(request_8xxirq);

into arch/ppc/kernel/ppc_ksyms.c and it should work.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
