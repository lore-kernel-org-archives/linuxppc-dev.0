Return-Path: <paravpandit@yahoo.com>
Received: from web36612.mail.mud.yahoo.com (web36612.mail.mud.yahoo.com
	[209.191.85.29]) by ozlabs.org (Postfix) with SMTP id 8C46967CAA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 22:52:08 +1000 (EST)
Message-ID: <20060824125206.18305.qmail@web36612.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 05:52:06 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: MPC8555 PCI interrupts are not coming
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-529286412-1156423926=:17980"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-529286412-1156423926=:17980
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  Can someone give light on PCI interrupts routing to the OS from the openPIC?
   
  Basically I am able to talk to PCI end device connected on MPC8555 board in 2.6.13 but not getting interrupts reported by my device.
   
  When I read the INTERRUPT_LINE byte, it comes as 0. pdev->irq is also reporting 0.
  Due to that request_irq() fails. But now I request for IRQ line 8 + openPIC offset.
  Handler gets registered but still not getting the interrupts. (PCI interrupt line is 8,9 in case of MPC8555).
   
  Can anyone please guide me, what are the different things need be configure in the platform code to receive the PCI interrupts in the driver?
   
  I don't understand the pci_irq_table, and what it should represent?
  Currrently no one is writing the INTERRUPT LINE value in the config space.
  In which function I should configure that value? pcibios_fixup??
   
  Regards,
  Parav Pandit
   

 		
---------------------------------
Do you Yahoo!?
 Get on board. You're invited to try the new Yahoo! Mail.
--0-529286412-1156423926=:17980
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>Can someone give light on PCI interrupts routing to the OS from the openPIC?</div>  <div>&nbsp;</div>  <div>Basically I am able to talk to PCI end device connected on MPC8555 board in 2.6.13 but not getting interrupts reported by my device.</div>  <div>&nbsp;</div>  <div>When I read the INTERRUPT_LINE byte, it comes as 0. pdev-&gt;irq is also reporting 0.</div>  <div>Due to that request_irq() fails. But now I request for IRQ line 8 + openPIC offset.</div>  <div>Handler gets registered but still not getting the interrupts. (PCI interrupt line is 8,9 in case of MPC8555).</div>  <div>&nbsp;</div>  <div>Can anyone please&nbsp;guide me, what are the different things need be configure in the platform code to receive the PCI interrupts in the driver?</div>  <div>&nbsp;</div>  <div>I don't understand the pci_irq_table, and what it should represent?</div>  <div>Currrently no one is writing the INTERRUPT LINE value in the config space.</div> 
 <div>In which function I should configure that value? pcibios_fixup??</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1>Do you Yahoo!?<br> 
Get on board. <a href="http://us.rd.yahoo.com/evt=40791/*http://advision.webevents.yahoo.com/mailbeta">You're invited</a> to try the new Yahoo! Mail.
--0-529286412-1156423926=:17980--
