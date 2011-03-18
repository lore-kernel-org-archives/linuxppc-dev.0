Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51902B6FDE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2011 00:35:18 +1100 (EST)
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p2IDYjGN011005
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2011 06:34:46 -0700
Received: by iwn3 with SMTP id 3so4850639iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2011 06:34:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1300427072.22236.1277.camel@pasglop>
References: <1300427072.22236.1277.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Mar 2011 06:34:25 -0700
Message-ID: <AANLkTinLb0sg1H6GDbZiddqGQ4a0=GRLYFJbL0G1Kv62@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2011 at 10:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Here are the changes for this merge window for powerpc. One highlight
> is irq data conversion so we can get rid of the legacy stuff. The new
> Dynamic DMA windows for pSeries should also improve performances for
> some devices nicely on more recent machines/firmwares. Plus a little
> pack of embedded things.

Ok, I got a conflict with the of_platform_driver() removal which
looked pretty trivial, but since I don't have a ppc cross-compile
thing I couldn't even test-compile the end result. Please take a look
to see that it went ok..

                      Linus
