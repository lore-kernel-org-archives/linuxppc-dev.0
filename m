Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <010601c0fd39$ef0cca90$3877b5d3@dolbae>
From: "SangTae Ha" <stha@postech.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <B25E2E5A003CD311B61E00902778AF2A026376D8@SERVER1> <3B36700C.B775FB54@mvista.com>
Subject: RPXclassic PPCBOOT on RAM
Date: Mon, 25 Jun 2001 14:44:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to have the PPCBOOT work on RPXclassic board. I've already port the 8xxROM this board already but I've failed with PPCBOOT. All configuration parameters are same with 8xxROM and my BDI2000 didn't get the flash information of RPXClassic (FLASH TYPE, CHIPSIZE, BUSWIDTH), therefore I really want to test the PPCBOOT on RAM space first to debug. In order to make srec file run on RAM space, I changed TEXT_BASE=0x00100000 parameter in config.mk. I think there woule be many efficient debugging techniques. I am currently using BDI2000, as I mentioned above, but I couldn't get the flash work. How can I debug the PPCBOOT efficiently in my current stage? Any comments would be appreciated.

Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
