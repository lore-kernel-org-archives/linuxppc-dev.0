Return-Path: <wei.li4@elf.mcgill.ca>
Received: from torrent.cc.mcgill.ca (torrent.CC.McGill.CA [132.206.27.49])
	by ozlabs.org (Postfix) with ESMTP id AE6F167C90
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 07:33:28 +1000 (EST)
Received: from mailscan2.cc.mcgill.ca (mailscan2.CC.McGill.CA [132.216.77.249])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k9PLXPCc010542
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Oct 2006 17:33:26 -0400
Received: from wgrappe2.cc.mcgill.ca (wgrappe2.CC.McGill.CA [132.216.46.251])
	by mailscan2.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k9PLX4Vo025597 for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 17:33:04 -0400 (EDT)
Received: from wgrappe2.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k9PLX453007547
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Oct 2006 17:33:04 -0400
Received: (from apache@localhost)
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k9PLX4vT007544
	for linuxppc-embedded@ozlabs.org; Wed, 25 Oct 2006 17:33:04 -0400
Message-ID: <20061025173304.c57o9tf3go000wc0@webmail.mcgill.ca>
Date: Wed, 25 Oct 2006 17:33:04 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Kernel hangs in console_init()
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am working on linux 2.6.18-rc2 with my mpc875 demo board, I used 
Debugger LEDs to find that kernel stopped in:
	while (call < __con_initcall_end) {
		(*call)();
		call++;
        }
which is in console_init() of tty_io.c, what kind of problem could be?
What's the means of 'bctrl' instruction that I found in its assembler?

Thanks,
Wei
