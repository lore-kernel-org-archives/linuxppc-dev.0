Return-Path: <SRS0+6268839a6384cbb21a2e+1002+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 710A9679FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 07:51:03 +1000 (EST)
Subject: Re: Viable PPC platform?
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060509223113.5715D353DB1@atlas.denx.de>
References: <20060509223113.5715D353DB1@atlas.denx.de>
Content-Type: text/plain
Date: Mon, 22 May 2006 22:51:13 +0100
Message-Id: <1148334674.10288.30.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-10 at 00:31 +0200, Wolfgang Denk wrote:
> And if somebody wants to see facts and numbers, please see
> http://www.denx.de/wiki/view/DULG/RootFileSystemSelection

Out of interest, how old is that JFFS2 test? If it's with the ancient
code in the 2.4 kernel, you'll get a _lot_ of improvement by using the
2.6 kernel.

It looks like it took about 13 seconds to mount the onboard 8MiB flash.
I can mount 512MiB of flash in 7.9 seconds with the current kernel, with
a 400MHz AMD Geode.

There's more work going on right now to reduce the memory usage too.

-- 
dwmw2
