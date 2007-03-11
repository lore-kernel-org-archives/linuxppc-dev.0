Return-Path: <melinda.develey70@yahoo.com>
Received: from web63001.mail.re1.yahoo.com (web63001.mail.re1.yahoo.com
	[69.147.96.212]) by ozlabs.org (Postfix) with SMTP id 3846FDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 08:57:06 +1100 (EST)
Message-ID: <20070311215705.59806.qmail@web63001.mail.re1.yahoo.com>
Date: Sun, 11 Mar 2007 14:57:05 -0700 (PDT)
From: melinda develey <melinda.develey70@yahoo.com>
Subject: Xenomai real time driver and normal linux driver mutual exclusion
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-590595006-1173650225=:58341"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-590595006-1173650225=:58341
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have an I2C bus, some devices should be controlled by a normal linux driver  but an ADC and a DAC on this bus should be controlled by a real time xenomai driver because, after a READ from the DAC I have to write to the ADC every 500 usec. I tried to use the normal linux driver from a xenomai real time user mode task but reading DAC, doing some computations, and writing to the ADC takes more than 500 usec. I thought to write both a RTDM driver for my 8xx I2C controller and a normal linux driver, but, how may I serialize access to the 8xx  I2C controller from these drivers?

Bye,
Antonio.

 
---------------------------------
Bored stiff? Loosen up...
Download and play hundreds of games for free on Yahoo! Games.
--0-590595006-1173650225=:58341
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have an I2C bus, some devices should be controlled by a normal linux driver&nbsp; but an ADC and a DAC on this bus should be controlled by a real time xenomai driver because, after a READ from the DAC I have to write to the ADC every 500 usec. I tried to use the normal linux driver from a xenomai real time user mode task but reading DAC, doing some computations, and writing to the ADC takes more than 500 usec. I thought to write both a RTDM driver for my 8xx I2C controller and a normal linux driver, but, how may I serialize access to the 8xx&nbsp; I2C controller from these drivers?<br><br>Bye,<br>Antonio.<br><p>&#32;

<hr size=1><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Bored stiff?</a> Loosen up...<br><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Download and play hundreds of games for free</a> on Yahoo! Games.
--0-590595006-1173650225=:58341--
