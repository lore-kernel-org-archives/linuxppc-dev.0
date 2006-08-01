Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id A1C7F67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 20:00:50 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 01 Aug 2006 12:00:48 +0200
From: GSM909@gmx.de
Message-ID: <20060801100048.266000@gmx.net>
MIME-Version: 1.0
Subject: SPI Problem
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

Hi

I´m writing a Driver for SPI. That is not working now.
I have a MPC8260 using Linux 2.6.14 (rheap patch).


My Problems and Questions

1. The Pointer in my BD to my "Buffer Pointer" is in external memory, I normaly allocated with kmalloc. Are this ok or need I a SDMA Page ?

2. My SPCOM[STR] flag isn´t cleared automatically after one clock cycle.
What here going wrong ?

I hope somebody could help. Thx

Regards
Fred

-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
