Return-Path: <pradeepsampath@yahoo.com>
Received: from web83203.mail.mud.yahoo.com (web83203.mail.mud.yahoo.com
	[216.252.101.47]) by ozlabs.org (Postfix) with SMTP id A6CA467C1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 10:18:57 +1000 (EST)
Message-ID: <20061013001856.69302.qmail@web83203.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 17:18:55 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: RE: plb_temac, ML403, linux 2.4.26, EDK 7.1
To: Ming Liu <eemingliu@hotmail.com>
In-Reply-To: <BAY110-F29333102EBA79FA70A2873B2140@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1795559097-1160698735=:65792"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1795559097-1160698735=:65792
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Guys,
   
  I need your help on this, i am stuck for over a week now. I am currently using
  ML403 Virtex-4 FX12 board, linux kernel 2.6.17.1, EDK 8.1.2i, and Ameet's sysace and TEMAC driver patch. With your help I was able to get the Kernel to boot on the ML403 board. But kernel crashes at xsysace_init function call.
  [    3.995416] Call Trace:
[    4.024581] [C04A1D20] [FFFFFFFF] 0xffffffff (unreliable)
[    4.089156] [C04A1D40] [C021D358] xsysace_init+0x50/0x330
[    4.153726] [C04A1F90] [C0002448] init+0xa4/0x27c
[    4.209968] [C04A1FF0] [C000509C] kernel_thread+0x44/0x60

   
  Since I am using 8.1.2i to generate the BSP, i suspect that the xparamater_ml300.h file the EDK generates for the ML403 board is not compatible with the sysace driver patch. I suspect that if i include a xparameters_ml300.h file that was generated using EDK 7.1 it would run. 
   
  Ming, would it be possible for you to send me a xparameters.h file using EDK 7.1 (or the version you are using) with very basic IP cores that will work with the sysace and TEMAC drivers. Thanks in advance.
   
  I need to get the sysace driver and TEMAC driver's up and running for the project. Any suggestions will be very helpful...
   
  -Pradeep

--0-1795559097-1160698735=:65792
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div><BR>Guys,</div>  <div>&nbsp;</div>  <div>I need your help on this, i am stuck for over a week now. I am currently using</div>  <div>ML403 Virtex-4 FX12 board, linux kernel 2.6.17.1, EDK 8.1.2i, and Ameet's sysace and TEMAC driver patch. With your help I was able to get the Kernel to boot on the ML403 board. But kernel crashes at xsysace_init function call.</div>  <div>[&nbsp;&nbsp;&nbsp; 3.995416] Call Trace:<BR>[&nbsp;&nbsp;&nbsp; 4.024581] [C04A1D20] [FFFFFFFF] 0xffffffff (unreliable)<BR>[&nbsp;&nbsp;&nbsp; 4.089156] [C04A1D40] [C021D358] xsysace_init+0x50/0x330<BR>[&nbsp;&nbsp;&nbsp; 4.153726] [C04A1F90] [C0002448] init+0xa4/0x27c<BR>[&nbsp;&nbsp;&nbsp; 4.209968] [C04A1FF0] [C000509C] kernel_thread+0x44/0x60<BR></div>  <div>&nbsp;</div>  <div>Since I am using 8.1.2i to generate the BSP, i suspect that the xparamater_ml300.h file the EDK generates for the ML403 board is not compatible with the sysace driver patch. I suspect that if i include a xparameters_ml300.h
 file that was generated using EDK 7.1 it would run. </div>  <div>&nbsp;</div>  <div>Ming, would&nbsp;it be possible for you to send me a xparameters.h file using EDK 7.1 (or the version you are using) with very basic IP cores that will work with the sysace and TEMAC drivers. Thanks in advance.</div>  <div>&nbsp;</div>  <div>I need to get the sysace driver and TEMAC driver's up and running for the project. Any suggestions will be very helpful...</div>  <div>&nbsp;</div>  <div>-Pradeep</div>
--0-1795559097-1160698735=:65792--
