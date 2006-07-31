Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 2A5B167B5E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 18:50:24 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 31 Jul 2006 10:50:22 +0200
From: GSM909@gmx.de
Message-ID: <20060731085022.138740@gmx.net>
MIME-Version: 1.0
Subject: cpm_dpalloc
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All

I have a MPC82xx Processor from Freescale with Linux 2.6.14 ( Can´t chance to an new version).

My Problem is that I want to allocate a 64byte of memory in the dual ported ram with an alignment of 64bytes. (Needed for SPI Parameter Ram)

the funktion cpm_dpalloc(64,64) returned 0x220 but that are not in a 64 byte alignment. 

Regards 
Fred
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
