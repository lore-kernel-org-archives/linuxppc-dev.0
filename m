Return-Path: <johnnyb@eskimo.com>
Received: from ultra7.eskimo.com (ultra7.eskimo.com [204.122.16.70])
	by ozlabs.org (Postfix) with ESMTP id BFFB367B56
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 14:12:36 +1000 (EST)
Received: from eskimo.com (johnnyb@eskimo.com [204.122.16.13])
	by ultra7.eskimo.com (8.13.6/8.13.4) with ESMTP id k6O41WUO027593
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Jul 2006 21:01:32 -0700
Date: Sun, 23 Jul 2006 21:01:38 -0700 (PDT)
From: Jonathan Bartlett <johnnyb@eskimo.com>
To: linuxppc-dev@ozlabs.org
Subject: Why the "opd" section?
Message-ID: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm learning PPC64 assembly language, and I found the existence of the
"opd" sections containing function descriptors quite odd.  What is the use
of these?  Are they used by the linker?  Why are they needed in the 64-bit
ELF platforms and not the 32-bit ones?

Thanks,

Jon
