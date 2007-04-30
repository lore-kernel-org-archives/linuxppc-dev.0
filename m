Return-Path: <simon@fire.lp0.eu>
Received: from proxima.lp0.eu (proxima.lp0.eu [85.158.45.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "proxima.lp0.eu",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40C5FDE0D8
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 04:07:18 +1000 (EST)
Message-ID: <46362B14.6090106@simon.arlott.org.uk>
Date: Mon, 30 Apr 2007 18:44:52 +0100
From: Simon Arlott <simon@fire.lp0.eu>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Revert "[POWERPC] <various>"
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are a few powerpc patches plus reverts in the recent push to torvalds/linux-2.6 - shouldn't this be avoided whenever possible because it could cause problems for people trying to use git bisect?

-- 
Simon Arlott
