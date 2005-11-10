Return-Path: <nitesh.guinde@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id BD67268705
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 05:26:11 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so689200wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 10:26:10 -0800 (PST)
Message-ID: <4fb800d20511101026g626b8126wb93ea6c4c5a5eac7@mail.gmail.com>
Date: Thu, 10 Nov 2005 13:26:10 -0500
From: Nitesh Guinde <nitesh.guinde@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: "Now booting the kernel"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Nathael,
I tried the stuff but I am still getting the same result.
I did not find the  section "/* 2. Invalidate all entries except the
 entry we're executing in */" So I commented the TLBWE line in the
section which says "invalidate all TLB entries " . Is it correct? The
ASM code for rebooting will have to be changed for my board... right?
Nitesh
