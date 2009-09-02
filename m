Return-Path: <azilkie@datacast.com>
Received: from datacast.com (mail.datacast.com [209.87.232.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A01E4B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 07:37:28 +1000 (EST)
Received: from [192.168.2.131] by datacast.com (MDaemon PRO v9.6.1)
	with ESMTP id md50001427974.msg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2009 17:31:04 -0400
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Adam Zilkie <azilkie@datacast.com>
To: chris.pringle@oxtel.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain
Date: Wed, 02 Sep 2009 17:22:52 -0400
Message-Id: <1251926572.10090.17.camel@Adam>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>
Reply-To: azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chris,

I am having a problem similar to what you described in this discussion.
We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with compiles
arch/ppc/kernel/head_44x.c (quite different
from /arch/powerpc/kernel/head_32.S). I would like to apply your
backporting patch to this architecture. Any help would be appreciated.

Regards,
Adam 

-- 
Adam Zilkie
Software Designer,
International Datacasting Corp.

This message and the documents attached hereto are intended only for the addressee and may contain privileged or confidential information. Any unauthorized disclosure is strictly prohibited. If you have received this message in error, please notify us immediately so that we may correct our internal records. Please then delete the original message. Thank you.
