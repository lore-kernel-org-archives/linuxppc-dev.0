Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BCA6168781
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 05:54:06 +1100 (EST)
Message-ID: <437A2EC7.2030503@varma-el.com>
Date: Tue, 15 Nov 2005 21:53:59 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain; charset=KOI8-R
Cc: linux-kernel@vger.kernel.org,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert
 platform drivers to use_ (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Russell,

I fear it is not a last patch of such kind :(.
Please recheck places where you are changed
pdev<->dev.

-- 
Regards
Andrey Volkov
