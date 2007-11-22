Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ACC8CDDDD6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:18:18 +1100 (EST)
Date: Thu, 22 Nov 2007 09:20:29 -0600
From: Olof Johansson <olof@lixom.net>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH] PPC: trivial fix of missed increment on counter
Message-ID: <20071122152029.GA7678@lixom.net>
References: <aa79d98a0711210056n6cc951atf4c6af5be26c1ed0@mail.gmail.com>
	<aa79d98a0711210258t3e6f5532oe710c04b93b06c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa79d98a0711210258t3e6f5532oe710c04b93b06c8@mail.gmail.com>
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

On Wed, Nov 21, 2007 at 01:58:06PM +0300, Cyrill Gorcunov wrote:
> On 11/21/07, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > This patch does fix missed increment on counter
> >
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > ---
> > Sorry for that nonstandart patch submission - I've only access
> > to gmail with Internet Explorer on my work. If that is not OK - will resend
> > the patch today evening with mutt.
> >
> >
> Oops - it seems the patch is corrupted a bit. Drop it please - will
> resend today evening. Sorry.

Thanks for the fix, but please cc the maintainer (me) next time, as well
as the arch list (linuxppc-dev@ozlabs.org)?

That loop could actually even easier be converted to a
for_each_compatible_node() iteration. There's never more than one
interface on the current boards but it's still nicer coding.

Thanks,

-Olof
