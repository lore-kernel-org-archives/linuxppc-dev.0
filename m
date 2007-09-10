Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 5B0C6DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 04:28:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1824311wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 11:28:14 -0700 (PDT)
Message-ID: <fa686aa40709101128q557f51c9n24fd5404bb1d51cb@mail.gmail.com>
Date: Mon, 10 Sep 2007 12:28:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Need confirmation on MP8349 configuration problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey Timur,

As we talked about on IRC, I'm having problems getting the BDI-2000 to
configure the MPC8349 when CFG_RESET_SOURCE is set to a hard coded
config (Like 100 or 111).

Can you please confirm what I'm seeing on one of your boards?

Steps to reproduce:

1. Set BDI config to override default RCW and initialize FLASH/RAM
2. Power up board and verify that BDI can read DDR and FLASH (using md commands)
3. Power down and remove jumpers A, B & C.
4. Power up and read DDR/FLASH again.  At this point I get '# SAP:
read access failed' from the BDI-2000.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
