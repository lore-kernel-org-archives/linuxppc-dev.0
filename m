Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (mail.biologigrand.se [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id B3E5967A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 00:21:28 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id 3470864426F for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Mar 2005 14:21:25 +0100 (CET)
Received: from 220a.licentiaten.umea.hsb.se (220a.licentiaten.umea.hsb.se
	[212.32.155.230])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id 6BA076428D7 for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Mar 2005 14:21:24 +0100 (CET)
Date: Mon, 14 Mar 2005 14:21:36 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.50.0503141403160.18512-100000@220a.licentiaten.umea.hsb.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Subject: PCMCIA for 8xx with 8- and 16-bit access
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm working with a custom made board based on A&M Adder875 with added PCMCIA
slot. The hardware guys connected the data bus via two 8bit buffer chips. Each
buffer chip has its own chip select line (CS) connected directly to the MPC875
cpu. I think that the idea was to support both 8- and 16-bit access to the
PCMCIA slot. One CS line controls the odd bytes and the other the even ones.

Is there any way to tell the memory controler to use one chip select line for
odd adresses in an interval and another for even in the same interval? I did
not find any information about that in the MPC885 Reference Manual.

One solution to the problem would be to connect the two CS lines together and
only use 16bit access. Must 8bit access be supported for the PCMCIA to work or
can I use 16bit for everything? I need support for both IDE and Wireless LAN.

Thanks,

/Markus

---
Markus Westergren
Ume√,•Sweden
