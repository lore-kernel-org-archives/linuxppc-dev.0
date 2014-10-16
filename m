Return-Path: <ydroneaud@opteya.com>
Message-ID: <1413450624.17854.3.camel@localhost.localdomain>
From: Yann Droneaud <ydroneaud@opteya.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 16 Oct 2014 11:10:24 +0200
In-Reply-To: <1413251832.21120.4.camel@concordia>
References: <cover.1413223900.git.ydroneaud@opteya.com>
 <9a145561123e28585d7994b61359a531128a80b8.1413223900.git.ydroneaud@opteya.com>
 <1413251832.21120.4.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCHv9 2/5] ppc/cell: trivial: replace get_unused_fd() by
 get_unused_fd_flags(0)
Cc: cbe-oss-dev@lists.ozlabs.org, Yann Droneaud <ydroneaud@opteya.com>,
 Jiri Kosina <trivial@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Le mardi 14 octobre 2014 à 12:57 +1100, Michael Ellerman a écrit :
> On Mon, 2014-10-13 at 21:30 +0200, Yann Droneaud wrote:
> > This patch replaces calls to get_unused_fd() with equivalent call to
> > get_unused_fd_flags(0) to preserve current behavor for existing code.
> > 
> > In a further patch, get_unused_fd() will be removed so that new code
> > start using get_unused_fd_flags(), with the hope O_CLOEXEC could be
> > used, either by default or choosen by userspace.
> > 
> > Link: http://lkml.kernel.org/r/cover.1413223900.git.ydroneaud@opteya.com
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: trivial@kernel.org
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> 
> This is fine by me, do you want an ack, or do you want us to take it via the
> powerpc tree?
> 

The patch was added in -mm by Andrew, so I guess the patch will be
merged sooner or later.

Anyway, you could investigate to check if O_CLOEXEC could be used
instead of 0 in call to get_unused_fd_flags().

> If the former:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 

Thanks a lot.

Regards.

-- 
Yann Droneaud
OPTEYA
