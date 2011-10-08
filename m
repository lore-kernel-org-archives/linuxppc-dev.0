Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
 [203.91.198.74])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B1B11B7091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2011 23:52:09 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: RE: BUG: scheduling while atomic:
Date: Sat, 8 Oct 2011 12:51:54 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE015506@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E8C9741.9010401@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Scott,

Below are the logs when I enable the kallsyms.
Any suggestion.


sh-3.1# I am in cpld_irq_handler
end cpld_irq_handler
BUG: scheduling while atomic: IRQ-20/0x0fff0000/108
Call Trace:
[C3B13EC0] [C0007DD0] show_stack+0x3c/0x194 (unreliable)
[C3B13EF0] [C0017F70] __schedule_bug+0x34/0x44
[C3B13F00] [C0269E38] schedule+0x31c/0x35c
[C3B13F50] [C0017FA4] __cond_resched+0x24/0x50
[C3B13F60] [C00180A4] cond_resched_hardirq_context+0x8c/0xfc
[C3B13F70] [C0047FBC] thread_simple_irq+0x78/0xc4
[C3B13F90] [C00482BC] do_irqd+0x2b4/0x32c
[C3B13FC0] [C0032BAC] kthread+0xc0/0xfc
[C3B13FF0] [C000F60C] original_kernel_thread+0x44/0x60



Regards,
Smitha
Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
