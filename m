Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B1FF0DDE45
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:30:28 +1100 (EST)
Date: Sun, 4 Feb 2007 16:37:54 -0600
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] [1/9] pasemi: Default root device
Message-ID: <20070204223754.GC2862@lixom.net>
References: <20070202045448.145851000@lixom.net>>
	<20070202045507.589087000@lixom.net>>
	<45C3BB0A.1020307@am.sony.com> <20070204221849.GA2862@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070204221849.GA2862@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2007 at 04:18:49PM -0600, olof wrote:

> What's no longer desired, the logic trying to figure out if NFS is the
> root, or setting a platform-specific root device if none is specified
> already?

After discussion on IRC; chances of actually making the right decision
for a user is fairly slim anyway, we should always rely on them (or
the bootloader) specifying the right thing on the command line instead.

I'll just drop it when I repost the series.


-Olof
