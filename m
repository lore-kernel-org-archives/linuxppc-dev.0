Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28B07DE0D3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 00:37:13 +1000 (EST)
Date: Tue, 14 Apr 2009 16:37:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] keywest: Convert to new-style i2c driver
Message-ID: <20090414163701.0609a189@hyperion.delvare>
In-Reply-To: <20090410170951.084e9b5c@hyperion.delvare>
References: <20090410170726.3616b6d5@hyperion.delvare>
	<20090410170951.084e9b5c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Apr 2009 17:09:51 +0200, Jean Delvare wrote:
> Ah, I forgot. You need the following patch applied before testing:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-loosen-driver-check.patch

This patch is is Linus' tree now:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=935298696f469c0e07c73be687bd055878074ce0

-- 
Jean Delvare
