Return-Path: <chaoyu5201314@yahoo.com>
Received: from web90009.mail.scd.yahoo.com (web90009.mail.scd.yahoo.com
	[66.218.94.67]) by ozlabs.org (Postfix) with SMTP id F1DF067A61
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 16:57:03 +1100 (EST)
Message-ID: <20050119055702.95200.qmail@web90009.mail.scd.yahoo.com>
Date: Tue, 18 Jan 2005 21:57:02 -0800 (PST)
From: chao yu <chaoyu5201314@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2070776965-1106114222=:94386"
Subject: How to initialize the extended ROM/Flash interface of MPC8245?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2070776965-1106114222=:94386
Content-Type: text/plain; charset=us-ascii

Hi,all
      I have a CPLD connected to the RCS3 of MPC 8245 processor. 
      Does the initialization of MPC8245's extended rom interface follow the two steps below?
      1. Set the Bit 21 of MCCR registers with 1 to enable the extended rom/falsh interface?
      2. Set the ERCR2 register(0xD4) and ERCR4 register(0xDC).
 
Any extra steps must be go?  Thx.
 
Regards,
Yu.Chao

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2070776965-1106114222=:94386
Content-Type: text/html; charset=us-ascii

<DIV>Hi,all</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have a CPLD connected to the RCS3 of MPC 8245 processor.&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Does the initialization of MPC8245's extended rom interface follow the two steps below?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Set the Bit 21 of MCCR registers with 1 to enable the extended rom/falsh interface?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Set the ERCR2 register(0xD4) and ERCR4 register(0xDC).</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any extra steps must be go?&nbsp; Thx.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards,</DIV>
<DIV>Yu.Chao</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-2070776965-1106114222=:94386--
