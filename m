Return-Path: <matthew@agrip.org.uk>
Received: from oblique.agrip.org.uk (i-195-137-71-106.freedom2surf.net
	[195.137.71.106]) by ozlabs.org (Postfix) with ESMTP id B230467B35
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2005 00:23:05 +1000 (EST)
From: "Matthew T. Atkinson" <matthew@agrip.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113089907.9517.446.camel@gaston>
References: <1113006674.9568.414.camel@gaston>
	<1113081689.15872.4.camel@localhost> <1113089907.9517.446.camel@gaston>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 15:16:25 +0100
Message-Id: <1113142585.5505.27.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

'ello,

On Sun, 2005-04-10 at 09:38 +1000, Benjamin Herrenschmidt wrote:
> If you set apps like xmms to actually use alsa output, you can have
> mixing but for that, you have to enable the dmix plugin in your alsa
> config. Look for infos about that on this list archive.

Thanks to both who suggested this; at last its all working with multiple
apps!

best regards,


-- 
Matthew T. Atkinson <matthew@agrip.org.uk>
