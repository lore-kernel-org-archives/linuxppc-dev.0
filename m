Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 248F167B57
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 02:45:23 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 15 Aug 2006 18:45:21 +0200
From: GSM909@gmx.de
Message-ID: <20060815164521.230780@gmx.net>
MIME-Version: 1.0
Subject: No Clock on SPI
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

Did someone else write a driver for SPI on this µC or an other driver? So I can see what i did wrong?

My SPCOM[STR] flag isn´t cleared automatically after one clock cycle.
What here going wrong ? ( I know this register is write only)
There is also no Clock on my SPICLK.

How I have to allocate the Memory for the BD´s and the buffer for the BD´s?

Is there something special when I allocate Memory for my Parameter Ram?

Is something wrong with the 2.6 Kernel so i have to use the 2.4 Kernel ?

I hope somebody could help. Thx

Regards
Fred

-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
