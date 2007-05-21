Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E72EDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 01:52:52 +1000 (EST)
Message-ID: <4651C04C.4040505@am.sony.com>
Date: Mon, 21 May 2007 08:52:44 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] set module owner in ps3 modules
References: <20070521125311.GA27626@aepfle.de>
	<20070521125426.GA27730@aepfle.de>
In-Reply-To: <20070521125426.GA27730@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> setting ->owner will help with refcounting (?) and it provides proper
> symlinks in sysfs.

Thanks.  I'm in the middle of re-doing the system bus and drivers to
work as loadable modules, and this will help.

-Geoff
