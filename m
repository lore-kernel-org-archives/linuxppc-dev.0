Return-Path: <evil@g-house.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD29967FC8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2005 20:42:48 +1000 (EST)
Received: from g147d.g.pppool.de ([80.185.20.125] helo=[192.168.10.31])
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1E3WgH-0008Dy-4C
	for linuxppc-dev@ozlabs.org; Fri, 12 Aug 2005 12:22:29 +0200
Message-ID: <42FC77F7.708@g-house.de>
Date: Fri, 12 Aug 2005 12:20:39 +0200
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050810093735.B22586@cox.net>
	<20050811194307.GW3187@smtp.west.cox.net>
In-Reply-To: <20050811194307.GW3187@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, Aug 10, 2005 at 09:37:35AM -0700, Matt Porter wrote:
>>If anybody has objections to this as the default, let me know. It
>>still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
>>affect the IBM PReP paths. My goal with this is to be able to run
>>a stock 2.6 defconfig PReP build on qemu.

i applied the patch to the latest 2.6-git tree and my PReP[1] boots just 
fine!

thanks for maintaining this exotic platform,
Christian.

[1] http://www.nerdbynature.de/bits/hal/2.6.13-rc6
-- 
BOFH excuse #367:

Webmasters kidnapped by evil cult.
