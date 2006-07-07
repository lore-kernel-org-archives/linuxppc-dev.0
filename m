Return-Path: <jagannathanjay@aim.com>
Received: from imo-d06.mx.aol.com (imo-d06.mx.aol.com [205.188.157.38])
	by ozlabs.org (Postfix) with ESMTP id 8A67167B65
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 19:05:32 +1000 (EST)
Received: from jagannathanjay@aim.com
	by imo-d06.mx.aol.com (mail_out_v38_r7.5.) id 5.561.fc60ff (57873)
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Jul 2006 05:05:24 -0400 (EDT)
Date: Fri, 07 Jul 2006 05:05:24 -0400
From: jagannathanjay@aim.com
Message-Id: <8C86FBB9DCF99D2-1D1C-336A@FWM-D43.sysops.aol.com>
Subject: SIU_INT_IRQ4 in MPC 8260
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

I am trying to set up a interrupt handler for SIU_INT_IRQ4.

The target I am using is MPC 8260 , emmbedded planet Evaluation board.

The OS is Embedded Linux .
-------------------------------------------------------------------------
------------
void my_interrupt_handler(int irq, void *dev_id, struct pt_regs *regs)
{

 printk("*********** \n");

}


 if( request_irq(SIU_INT_IRQ4,my_interrupt_handler,0,0,0) < 0)
 {
     printk("\n unable to register the interrupt handler \n");
 }

-------------------------------------------------------------------------
------------

But my_interrupt_handler isn't getting called .

Can anyone help me to fix this problem

Regards
Jagan





________________________________________________________________________
Check Out the new free AIM(R) Mail -- 2 GB of storage and 
industry-leading spam and email virus protection.
