Return-Path: <pravin3560@yahoo.com>
Received: from web50512.mail.yahoo.com (web50512.mail.yahoo.com
	[68.142.228.51]) by ozlabs.org (Postfix) with SMTP id B985267B61
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 08:39:41 +1000 (EST)
Message-ID: <20060502223259.55214.qmail@web50512.mail.yahoo.com>
Date: Tue, 2 May 2006 15:32:59 -0700 (PDT)
From: pravin <pravin3560@yahoo.com>
Subject: U-boot1.1.4 porting problem on PPC 440GX 
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2007005706-1146609179=:45416"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2007005706-1146609179=:45416
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi All,
  I build uboot1.1.4 for ocotea_config  and run on an ocotea without SPD on DIMMS (SDRAM) and  It works. We manufactured another board derived from Ocotea Ref design, 440GX processor and on baord SDRAM (DIMMS) 256MB discrete parts. I use the same Uboot1.1.4 for this board. It boots upto calling the 
   
  relocate_code in cpu/ppc4xx/start.S and hangs. The same code works well on Ocotea. I run the memory tests and it passed all.
   
  Any idea why this could hang and never finish the relocate_code function. Trying relocating Uboot to SDRAM memory to get the C environment and run from memory.
   
  Any help would be appreciated. Any idea if i need any special code because of the discrete parts of SDRAM on our board.
   
  Thanks,
  Pravin
   

--0-2007005706-1146609179=:45416
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi All,</div>  <div>I build uboot1.1.4 for&nbsp;ocotea_config&nbsp; and run on an ocotea without SPD on DIMMS (SDRAM) and &nbsp;It works. We manufactured another board derived from Ocotea Ref design, 440GX processor and on baord SDRAM (DIMMS) 256MB discrete parts. I use the same Uboot1.1.4 for this board. It boots upto calling the </div>  <div>&nbsp;</div>  <div>relocate_code in cpu/ppc4xx/start.S and hangs. The same code works well on Ocotea. I run the memory tests and it passed all.</div>  <div>&nbsp;</div>  <div>Any idea why this could hang and never finish the relocate_code function. Trying relocating Uboot to SDRAM memory to get the C environment and run from memory.</div>  <div>&nbsp;</div>  <div>Any help would be appreciated. Any idea if i need any special code because of the discrete parts of SDRAM on our board.</div>  <div>&nbsp;</div>  <div>Thanks,</div>  <div>Pravin</div>  <div>&nbsp;</div>
--0-2007005706-1146609179=:45416--
