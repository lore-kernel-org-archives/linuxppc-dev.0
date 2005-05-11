Return-Path: <DavidHo@nanometrics.ca>
Received: from mail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with SMTP id CB18A67A3B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 01:21:44 +1000 (EST)
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OFCC8DCA28.26829202-ON85256FFE.005266B1-85256FFE.005475C8@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 11 May 2005 11:22:31 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: libssl in ELDK3.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

I noticed that the libssl.so and libcrypto.so in the ELDK3.0 development
rootfs are built with the linux-elf option on the ppc when it should have
been built with linux-ppc.  When I was trying to build ssh with these libs,
it would not work with an i386 Linux box.  I had to build libssl from
scratch.

David
