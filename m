Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id C88BEDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:38:31 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so406757uge
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 07:38:31 -0800 (PST)
Date: Thu, 22 Nov 2007 18:38:23 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] PPC: trivial fix of missed increment on counter
Message-ID: <20071122153823.GA7273@cvg>
References: <aa79d98a0711210056n6cc951atf4c6af5be26c1ed0@mail.gmail.com>
	<aa79d98a0711210258t3e6f5532oe710c04b93b06c8@mail.gmail.com>
	<20071122152029.GA7678@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122152029.GA7678@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Olof Johansson - Thu, Nov 22, 2007 at 09:20:29AM -0600]
| On Wed, Nov 21, 2007 at 01:58:06PM +0300, Cyrill Gorcunov wrote:
| > On 11/21/07, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
| > > This patch does fix missed increment on counter
| > >
| > > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
| > > ---
| > > Sorry for that nonstandart patch submission - I've only access
| > > to gmail with Internet Explorer on my work. If that is not OK - will resend
| > > the patch today evening with mutt.
| > >
| > >
| > Oops - it seems the patch is corrupted a bit. Drop it please - will
| > resend today evening. Sorry.
| 
| Thanks for the fix, but please cc the maintainer (me) next time, as well
| as the arch list (linuxppc-dev@ozlabs.org)?
| 
| That loop could actually even easier be converted to a
| for_each_compatible_node() iteration. There's never more than one
| interface on the current boards but it's still nicer coding.
| 
| Thanks,
| 
| -Olof
| 

Sorry Olof for missing you. Will cc you and a list next time.
I'm trying to convert all for(;;) cycles to for_each_.. macro
now (actually during the convertation I found a few potential NULL
pointer dereferences so they are going first to list as I've done on them).
So as only I have it done I'll send it to a list (and you too ;) Thanks.

		Cyrill
