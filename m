Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 7C2AAB7D86
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 04:53:17 +1000 (EST)
Subject: Re: [PATCH 0/5] Removing dead code
From: Joe Perches <joe@perches.com>
To: Christoph Egger <siccegge@cs.fau.de>,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <cover.1275925219.git.siccegge@cs.fau.de>
References: <cover.1275925219.git.siccegge@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 11:46:52 -0700
Message-ID: <1276195612.1556.279.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, vamos@i4.informatik.uni-erlangen.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(cc's trimmed and rpjday added)

On Wed, 2010-06-09 at 11:58 +0200, Christoph Egger wrote:
> I've been running a check on the arch/powerpc sourcetree for
> config Items not defined in Kconfig and found5 such chases.

Are you aware of
http://www.crashcourse.ca/wiki/index.php/Kernel_cleanup_scripts

> [0] http://vamos1.informatik.uni-erlangen.de/
