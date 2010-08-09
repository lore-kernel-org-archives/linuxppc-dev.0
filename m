Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 776FFB70A5
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 15:18:41 +1000 (EST)
Received: by yxi11 with SMTP id 11so5893722yxi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 22:18:40 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1281327087.2168.67.camel@pasglop>
References: <1281327087.2168.67.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 8 Aug 2010 23:18:19 -0600
Message-ID: <AANLkTin0dkWPkU3C47HjnxZ2e_ujCUfNUp4xm_xSX3yK@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 8, 2010 at 10:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Linus !
>
> Here's a few misc things for .36. The big bit is that I trimmed all the
> defconfigs using make savedefconfig.
[...]
> =A0108 files changed, 270 insertions(+), 134609 deletions(-)

And how is anyone else to make it into the kernel statistics top
contributors by lines changed list with stuff like this going in?  :-)

g.
