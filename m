Return-Path: <sauros@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 1618F2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 22:31:43 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so111664wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 03:31:39 -0800 (PST)
Message-ID: <c359a7c0041124031663464354@mail.gmail.com>
Date: Wed, 24 Nov 2004 09:16:34 -0200
From: Sauro Salomoni <sauros@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: CRAMFS decompression
Reply-To: Sauro Salomoni <sauros@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anybory know where I can find some good documentation about
CRAMFS file systems?

I am having a problem in my embedded linux system, in wich I use 2
file systems: CRAMFS for the OS and JFFS2 for the applications. When
it tries to decompress the CRAMFS partition, it crashes and reboots...
I need to know how the kernel deals with the data, and where the
decompressed data goes (RAMDISK? TMPFS?).
I am currently using a Lite5200 board with 2.4.25 Denx linux kernel.
Thanks in advance

-- 
Sauro Salomoni

Ztec - Engineering
Phone: +55 61 322-2544   FAX:+55 61 224-7171
www.ztec.com.br
