Return-Path: <paravpandit@yahoo.com>
Received: from web36606.mail.mud.yahoo.com (web36606.mail.mud.yahoo.com
	[209.191.85.23]) by ozlabs.org (Postfix) with SMTP id DC04F67C3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 18:56:45 +1000 (EST)
Message-ID: <20060825085643.47078.qmail@web36606.mail.mud.yahoo.com>
Date: Fri, 25 Aug 2006 01:56:43 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: pci_id_table and mid_idsel?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-362965229-1156496203=:42249"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-362965229-1156496203=:42249
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  Can someone please explain me pci_irq_table and how to select the value of min_idsel , max_idsel for my 85xx boards?
   
  I am facing issues in registering the interrupt handler.
   
  On what basis we have to select the min_idsel and max_idsel value??
   
  Currently common_swizzle function retuns slot number 11, if I hard-code the value of 11 in the min_idsel and max_idsel because I have only one slot, I am able to register the interrupt handler.
   
  PCI_SLOT in common_swizzle returns 11 because device function number (devfn) has value of 88  ( I am wondering why 88 instead of from 0-7).
  (( 88>> 8) && 0x1f) = 11
   
  Since max functions we can have 8. (0-7). Why OS assign the value of 88 inside?
  Configuration transaction uses only 3 bits of function number in the CONFIG_ADDRESS as per PCI local bus specification 2.2.
   
  Regards,
  Parav Pandit
   

 		
---------------------------------
 All-new Yahoo! Mail - Fire up a more powerful email and get things done faster.
--0-362965229-1156496203=:42249
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>Can someone please explain me pci_irq_table and how to select the value of min_idsel , max_idsel for my 85xx boards?</div>  <div>&nbsp;</div>  <div>I am facing issues in registering the interrupt handler.</div>  <div>&nbsp;</div>  <div>On what basis we have to select the min_idsel and max_idsel value??</div>  <div>&nbsp;</div>  <div>Currently common_swizzle function retuns slot number 11, if I hard-code the value of 11 in the min_idsel and max_idsel because I have only one slot, I am able to register the interrupt handler.</div>  <div>&nbsp;</div>  <div>PCI_SLOT in common_swizzle returns 11 because device function number (devfn) has value of 88&nbsp; ( I am wondering why 88 instead of from 0-7).</div>  <div>(( 88&gt;&gt; 8) &amp;&amp; 0x1f) = 11</div>  <div>&nbsp;</div>  <div>Since max functions we can have 8. (0-7). Why OS assign the value of 88 inside?</div>  <div>Configuration transaction uses only 3 bits of function number in the
 CONFIG_ADDRESS as per PCI local bus specification 2.2.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1><a href="http://us.rd.yahoo.com/evt=43256/*http://advision.webevents.yahoo.com/mailbeta"> All-new Yahoo! Mail </a>- Fire up a more powerful email and get things done faster.
--0-362965229-1156496203=:42249--
