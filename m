Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40EF9B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 23:03:55 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: RE: Request_irq fails for IRQ2
Date: Tue, 4 Oct 2011 11:21:45 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE014773@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E89EFB2.6060704@freescale.com>
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

I am able to register the IRQ now once I add the call irq_set_default_host i=
n cpm2_pic.
But when I call enable_irq the code throws the below warning and gives excep=
tion in enable irq at 
spin_unlock_irqrestore(&desc->lock, flags); in enable_irq.


printk(KERN_WARNING "Unbalanced enable for IRQ %d\n", irq);

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
