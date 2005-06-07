Return-Path: <andreas_schmidt@ifm-electronic.com>
Received: from mail1.ifm-electronic.com (mail1.ifm-electronic.com
	[62.180.229.59]) by ozlabs.org (Postfix) with ESMTP id BF446679F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 21:36:16 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF671B0D3C.F103C6BA-ONC1257019.003EF7C8-C1257019.003F8D1B@ifm-electronic.com>
From: andreas_schmidt@ifm-electronic.com
Date: Tue, 7 Jun 2005 13:34:10 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Kernel stack overflow on process 0xc00cd274
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

I still try to boot Linux with u-boot. I use Linux 2.4.24.
The problem is that near the begin on startup Kernel the Linux hanks. I find the log
buffer and there are massages folow:

Kernel Stack overflow on process 0xc00c4030
Kernel Stack overflow on process 0xc00c4460

Under this address I found in the System.map that this is the init_stack_union.

Know somebody why this conflict comes?

many thanks,
best regards,

Andreas Schmidt
