Message-ID: <20020611234337.46834.qmail@web11503.mail.yahoo.com>
Date: Tue, 11 Jun 2002 16:43:37 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: Ebony bootloader
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does the Ebony board port implement a bootloader? What
does the head_440.S file do in a nutshell?

If our custom board has peripheral devices hanging off
the EBC0, how should I initilize them and where in the
ebony port code? I browsed the source a little bit and
see the ebony.c source. I believe this is where you
add peripheral devices to the kernel. Am I right?

What is that ioremap64() anyway? Is this a kernel call
or a called supported by the firmware?

Thanks,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
