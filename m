Return-Path: <paravpandit@yahoo.com>
Received: from web36614.mail.mud.yahoo.com (web36614.mail.mud.yahoo.com
	[209.191.85.31]) by ozlabs.org (Postfix) with SMTP id 36E6867B89
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 21:10:30 +1000 (EST)
Message-ID: <20060718110350.28445.qmail@web36614.mail.mud.yahoo.com>
Date: Tue, 18 Jul 2006 04:03:50 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: page locking in PowerPC cores
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-980792983-1153220630=:26041"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-980792983-1153220630=:26041
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  We allocate memory for DMA operation on PCI device using pci_alloc_constistent().
   
  I want to know how this function is boil down to the actual instruction which locks the page in the RAM so that it cannot be paged out and dma can do its work.
   
  Can anybody tell me which instructions do we use to set this page entry in TLB and page table?
  What bit gets set in the PTE for this?
   
  Regards,
  Parav Pandit
   

 		
---------------------------------
Do you Yahoo!?
 Next-gen email? Have it all with the  all-new Yahoo! Mail Beta.
--0-980792983-1153220630=:26041
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>We allocate memory for DMA operation on PCI device using pci_alloc_constistent().</div>  <div>&nbsp;</div>  <div>I want to know how this function is boil down to the actual instruction which locks the page in the RAM so that it cannot be paged out and dma can do its work.</div>  <div>&nbsp;</div>  <div>Can anybody tell me&nbsp;which instructions do we use to set this page entry in TLB and page table?</div>  <div>What bit gets set in the PTE for this?</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1>Do you Yahoo!?<br> Next-gen email? Have it all with the <a href="http://us.rd.yahoo.com/evt=42241/*http://advision.webevents.yahoo.com/handraisers"> all-new Yahoo! Mail Beta.</a>
--0-980792983-1153220630=:26041--
