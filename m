Return-Path: <nix.or.die@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id D81DEDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 03:12:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so967783ugc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Jul 2007 10:12:02 -0700 (PDT)
Message-ID: <46ACC95D.5010702@googlemail.com>
Date: Sun, 29 Jul 2007 19:07:41 +0200
From: Gabriel C <nix.or.die@googlemail.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Fix compilation for non CONFIG_HOTPLUG case
References: <200707291807.52042.niklaus.giger@member.fsf.org>
	<46ACC42E.8040907@ru.mvista.com>
In-Reply-To: <46ACC42E.8040907@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii
Cc: niklaus.giger@member.fsf.org, linux-kernel@vger.kernel.org,
	kristen.c.accardi@intel.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This problem is already fixed in -mm .

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc1/2.6.23-rc1-mm1/broken-out/gregkh-driver-kobject-fix-link-error-when-config_hotplug-is-disabled.patch


Regards,

Gabriel
