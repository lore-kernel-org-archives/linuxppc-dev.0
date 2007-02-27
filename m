Return-Path: <paravpandit@yahoo.com>
Received: from web36603.mail.mud.yahoo.com (web36603.mail.mud.yahoo.com
	[209.191.85.20]) by ozlabs.org (Postfix) with SMTP id 22740DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 16:05:58 +1100 (EST)
Date: Mon, 26 Feb 2007 20:59:17 -0800 (PST)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Locking interrupt handler in L1 cache
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1774038784-1172552357=:52640"
Message-ID: <842614.52640.qm@web36603.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1774038784-1172552357=:52640
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
  
  I have 8548 Linux based firewall which will mostly do packet processing for 80% time.
  So obviously most of the time it will RX and TX packets through gianfar ethernet driver.
  
  I want to lock my interrupt handler of this driver in the L1 cache.
  1. How can I use "icbtls" - Instruction Cache Block Touch and Lock Set" for locking my interrupt handler?
  
  2. Is "icbtls" is the correct instruction at which I am looking at?
  
  3. How do I find end address of the interrupt handler function and how  do we pass it to cache locking instructions? (Because it can happen  that interrupt handler size is more than a cache line, not aligned etc)?
  
  4. Can we enhance request_irq() function to take an additional parameter to lock the interrupt handler in the cache?
  
  I understand that if my interrupt handler is going to be called most of  the time then it is very likely to happen that OS will flush the same,  but there is no guarantee for it.
  
  Regards,
  Parav Pandit
  
 
---------------------------------
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
--0-1774038784-1172552357=:52640
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br>  <br>  I have 8548 Linux based firewall which will mostly do packet processing for 80% time.<br>  So obviously most of the time it will RX and TX packets through gianfar ethernet driver.<br>  <br>  I want to lock my interrupt handler of this driver in the L1 cache.<br>  1. How can I use "icbtls" - Instruction Cache Block Touch and Lock Set" for locking my interrupt handler?<br>  <br>  2. Is "icbtls" is the correct instruction at which I am looking at?<br>  <br>  3. How do I find end address of the interrupt handler function and how  do we pass it to cache locking instructions? (Because it can happen  that interrupt handler size is more than a cache line, not aligned etc)?<br>  <br>  4. Can we enhance request_irq() function to take an additional parameter to lock the interrupt handler in the cache?<br>  <br>  I understand that if my interrupt handler is going to be called most of  the time then it is very likely to happen that OS will flush the same,  but there is no
 guarantee <span style="font-size: 12pt; font-family: &quot;Times New Roman&quot;;"></span>for it.<br>  <br>  Regards,<br>  Parav Pandit<br>  <p>&#32;

<hr size=1>Be a PS3 game guru.<br>Get your game face on with <a href="http://us.rd.yahoo.com/evt=49936/*http://videogames.yahoo.com">the latest PS3 news and previews at Yahoo! Games.</a>
--0-1774038784-1172552357=:52640--
