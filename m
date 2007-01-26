Return-Path: <recon_pje@yahoo.com>
Received: from web58801.mail.re1.yahoo.com (web58801.mail.re1.yahoo.com
	[66.196.100.215]) by ozlabs.org (Postfix) with SMTP id 6F5F9DDFF9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 06:48:42 +1100 (EST)
Date: Fri, 26 Jan 2007 11:42:01 -0800 (PST)
From: Paul Eaton <recon_pje@yahoo.com>
Subject: MPC8248 poor performance
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1329231078-1169840521=:77350"
Message-ID: <404123.77350.qm@web58801.mail.re1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1329231078-1169840521=:77350
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  We have a custom 8248 card that we are testing. 
  The core is running at 400MHz and the system bus is 80Mhz (measured and verified), 32 bit wide memory interface.
  There is nothing connected to the CPM except 1 RS232 port which is not used in our test loop.
   
  We are running a small test C loop (with approx. 60 assembly language instructions) at the end of u-boot as in the Hello World example. The loop runs fine but upon closer analisis I found that each loop takes 6uS. This averages out to 100nS/instruction = 10MIPS = sad performance. I would have expected at least 100MIPS or more.
   
  I've checked the HID0 SPR register to verify that the instruction cache is enabled.
   
  I've also stepped thru the code to verify that the code stays within the loop (no async branches or irqs). Looking at the adr and data lines with an analyzer the loop appears to do the correct amount of I/O to SDRAM but the amount of time of between SDRAM accesses seem longer than I would expect if caching, pipelining, snooping, etc are enabled.
   
  Any ideas on what could be slowing the CPU down are greatly appreciated.
   
  Paul

 
---------------------------------
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
--0-1329231078-1169840521=:77350
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>We have a custom 8248 card that we are testing. </div>  <div>The core is running at 400MHz and the system bus is 80Mhz (measured and verified), 32 bit wide memory interface.</div>  <div>There is nothing connected to the CPM except 1 RS232 port which is not used in our test loop.</div>  <div>&nbsp;</div>  <div>We are running a small test C loop (with approx. 60 assembly language instructions) at the end of u-boot as in the Hello World example. The loop runs fine but upon closer analisis I found that each loop takes 6uS. This averages out to 100nS/instruction = 10MIPS = sad performance. I would have expected&nbsp;at least&nbsp;100MIPS or more.</div>  <div>&nbsp;</div>  <div>I've checked the HID0 SPR register to verify that the instruction cache is enabled.</div>  <div>&nbsp;</div>  <div>I've also stepped thru the code to verify that the code stays within the loop (no async branches or irqs). Looking at the adr and data lines with an
 analyzer the loop appears to do the correct amount of I/O to SDRAM but the amount of time of between SDRAM accesses seem longer than&nbsp;I would expect if&nbsp;caching, pipelining, snooping, etc are enabled.</div>  <div>&nbsp;</div>  <div>Any ideas on what could be slowing the CPU down are greatly appreciated.</div>  <div>&nbsp;</div>  <div>Paul</div><p>&#32;

<hr size=1>Don't pick lemons.<br>
See all the <a href="http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE0OGRsc3F2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3Y2Fycw--">new 2007 cars</a> at <a href="http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE0OGRsc3F2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3Y2Fycw--">Yahoo! Autos.</a>
--0-1329231078-1169840521=:77350--
