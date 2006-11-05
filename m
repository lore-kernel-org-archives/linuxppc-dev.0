Return-Path: <dvbspider@hotmail.com>
Received: from bay0-omc3-s30.bay0.hotmail.com (bay0-omc3-s30.bay0.hotmail.com
	[65.54.246.230]) by ozlabs.org (Postfix) with ESMTP id A9CA867C45
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 14:46:37 +1100 (EST)
Message-ID: <BAY121-F14257B62A0324A08AC99C6A6FC0@phx.gbl>
From: "jhon scoot" <dvbspider@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: hi, guy's Need help to jtag a PPC405D4
Date: Sat, 04 Nov 2006 22:46:34 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,,

guy,,

I am trying to read my PPC405D4,, the problem is , my serial cable DB9 to 
RJ12 is missing , and I need
to configure my Riscwatch Probe setting up the IP/TCP ,, does some one have 
, a Riscwatch probe, and and check the serial cable how is configurated, for 
I can buil'it here.

Example: This is a example...
RJ12 to DB9 (DCE Male) converter:

		DCD	1  <--------  1	DCD
		RXD	2  <--------  2	RXD
	      DTR/RTS	3  -------->  4	DTR
          |_>  7	RTS
RJ12		GND	4  ----------  5	GND	DB9
		TXD	5  -------->  3	TXD
		CTS	6  <--------  8	CTS


thnkas

_________________________________________________________________
Get today's hot entertainment gossip  
http://movies.msn.com/movies/hotgossip?icid=T002MSN03A07001
