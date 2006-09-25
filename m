Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87CC467B5D
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 18:53:04 +1000 (EST)
Subject: Re: [PATCH] aoa is pmac-only
From: Johannes Berg <johannes@sipsolutions.net>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20060923002425.GY29920@ftp.linux.org.uk>
References: <20060923002425.GY29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 10:53:25 +0200
Message-Id: <1159174405.4509.8.camel@ux156>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-09-23 at 01:24 +0100, Al Viro wrote:

>  menu "Apple Onboard Audio driver"
> -	depends on SND!=n && PPC
> +	depends on SND!=n && PPC_PMAC

Oh, that's right.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes
