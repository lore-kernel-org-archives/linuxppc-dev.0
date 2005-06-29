Return-Path: <cldong@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.200])
	by ozlabs.org (Postfix) with ESMTP id 489B567B7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 02:46:06 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so2070227rne
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 09:46:05 -0700 (PDT)
Message-ID: <b8fbdd1e05062909398f091c1@mail.gmail.com>
Date: Wed, 29 Jun 2005 09:39:55 -0700
From: Chunlei Dong <cldong@gmail.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: /sbin/init is not beeing scheduled to run
Reply-To: Chunlei Dong <cldong@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,=20

I am trying to boot the linux 2.6.11.5 in high memory, that means the
phys memory does not start from 0, but 0x04000000, on ppc440gp ebony
board.  I changed the TLB setting and register settings for bdinfo,
cmdline. Now it seems ok to run to the end of the process 0. After the
start_thread() in load_elf_binary(), which loaded the "/sbin/init",
the cpu becomes idle state, the /sbin/init process(the process 1) is
never been scheduled to run.
Anybody encountered this problem or give a hint?

Best regards
- Charlie
