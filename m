Return-Path: <andreas_schmidt@ifm-electronic.com>
Received: from mail1.ifm-electronic.com (mail1.ifm-electronic.com
	[62.180.229.59]) by ozlabs.org (Postfix) with ESMTP id 5D59467B2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 19:16:14 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF0DB417C7.83A70907-ONC1256FEE.00309ED0-C1256FEE.00318870@ifm-electronic.com>
From: andreas_schmidt@ifm-electronic.com
Date: Mon, 25 Apr 2005 11:01:01 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: u-boot Memec Evaluation Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi at all

I'm new there and i try to port the u-boot to memec insight Evaluation Board.
My Configurations:
Memec Insight Evaluation Board with Virtex2Pro
P160 Communications Module

I want to imlement in the u-boot at first the Flash and then Ethernet at P160 Module.
And i want to communicate with u-boot at RS232 Interface.
I have placed xparameters.h in config/ml300.
What must i modify at ml300.h and perhaps other files to adjust the u-boot to my board?
Or perhaps have anyone a ready patch for the board?

I now treing to do something but i get allways errors at compile the u-boot.
