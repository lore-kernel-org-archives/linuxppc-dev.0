Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 7EF8067C1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 05:32:33 +1000 (EST)
Received: from mx35.stngva01.us.mxservers.net (204.202.242.106)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	4-0175343149 for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 15:32:31 -0400 (EDT)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 13 Jul 2005 12:32:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <20050713153231.GA17534@mail19d.g19.rapidsite.net>
Subject: linux and sram
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,


If we are using U-boot and populate the CFG_SRAM_SIZE and CFG_SRAM_BASE
values, and makes sure this is passed into the kernel.

Does Linux 2.4.2x+ have any direct support for this? Is it just added into
the regular memory pool? Does it get used for specific tasks?

Or is this set aside for custom drivers?

Thanks,

Russell McGuire
