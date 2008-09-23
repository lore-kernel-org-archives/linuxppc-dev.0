Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 6417DDDFB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 07:41:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How to use mtdcr from userland code
Date: Tue, 23 Sep 2008 16:41:49 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F7CC@tanisys-ex2.Tanisys.Local>
In-Reply-To: <5c9cd53b0809231156o3c24c053y26861d8f1cf24a93@mail.gmail.com>
References: <5c9cd53b0809231156o3c24c053y26861d8f1cf24a93@mail.gmail.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,

I am developing an app that needs to map pci address space to the PLB on
the ppc460ex.  From what I gather I need to use the mtcdr
instruction/macro to configure the PIM0 space.  However, I cannot figure
out how to use that from userland code.  Is it possible?  Can I change
the PIM some other way?

Thanks
