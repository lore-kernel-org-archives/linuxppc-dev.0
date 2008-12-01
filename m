Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id 0A95A474CD
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Dec 2008 08:06:16 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1L7FZ5-0003wv-Kh
	for linuxppc-embedded@ozlabs.org; Mon, 01 Dec 2008 15:40:20 -0500
Message-ID: <20081201154019.h2594e91344oc040@www.bish.net>
Date: Mon, 01 Dec 2008 15:40:19 -0500
From: Mark Bishop <mark@bish.net>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: MPC8313 + SPI question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When a slave SPI device needs to talk to the master 8313 it will pull  
down an interrupt pin and then the SPI driver needs to go out and  
service the SPI device.

Is this framework already built in to the SPI driver or am I going to  
have to hack apart the driver to add it?
