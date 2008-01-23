Return-Path: <johns.daniel@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id E9474DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 02:06:27 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2073378fgg.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 07:06:17 -0800 (PST)
Message-ID: <ba5d9360801230706n47ad71bapd1820488f823736f@mail.gmail.com>
Date: Wed, 23 Jan 2008 09:06:17 -0600
From: "Johns Daniel" <johns.daniel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: CONFIG_PCI interaction with pata_platform driver on MPC834x board
In-Reply-To: <ba5d9360712210737h133fd831vbfb7c9f996c6df7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ba5d9360712210737h133fd831vbfb7c9f996c6df7c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am asking this question once more since my previous try -- right
before the Christmas break -- did not elicit any responses!   ;~)

Without PCI support configured in the kernel, the CompactFlash card is
discovered and configured by the kernel. With PCI support configured
in the kernel, it fails to discover the CF card through the
pata_platform driver.

(Note that both PCI and CF work fine on this same board with the
generic IDE driver!)

There are only two differences that I notice between the two kernel
setups that might be significant:
1.) The libata virq changes from 19 to 20.
2.) The isa_io_base changes from 0x0 to 0xfcfff000.
Are either of these two changes significant?

I am using the "arch/powerpc" kernel, version 2.6.20.21. The CF is
wired directly to the local bus in True IDE mode.

I have some debug info included in my previous message at:

http://www.nabble.com/CONFIG_PCI-interaction-with-pata_platform-driver-on-MPC834x-board-tc14457502.html

TIA!

-- Johns
