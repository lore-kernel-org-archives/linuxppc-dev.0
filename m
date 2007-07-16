Return-Path: <aris@ruivo.org>
Received: from lobo.ruivo.org (lobo.ruivo.org [66.92.68.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lobo.ruivo.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96196DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:54:22 +1000 (EST)
Date: Mon, 16 Jul 2007 16:53:14 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] adb: make sysrq key configurable at runtime
Message-ID: <20070716205314.GB30232@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These two patches make possible to configure the sysrq key on ADB based
machines where the default sysrq key (0x69) is not present. The first
patch creates a class device for each handled device. The second one adds an
attribute to ADB keyboards that makes possible to configure the sysrq key
for each keyboard.

-- 
Aristeu
