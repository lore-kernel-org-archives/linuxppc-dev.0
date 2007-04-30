Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0B07ADDEC5
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 05:49:18 +1000 (EST)
Date: Mon, 30 Apr 2007 21:49:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: Revert "[POWERPC] <various>"
Message-ID: <20070430194911.GA1156@aepfle.de>
References: <46362B14.6090106@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46362B14.6090106@simon.arlott.org.uk>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, Simon Arlott wrote:

> There are a few powerpc patches plus reverts in the recent push to 
> torvalds/linux-2.6 - shouldn't this be avoided whenever possible because it 
> could cause problems for people trying to use git bisect?

The reverts do not cause compile failures (I hope).
You may lose IDE if you happen to debug something on Pegasos.
I'm sure the real bisect breakers are elsewhere.
