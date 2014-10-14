Return-Path: <mpe@ellerman.id.au>
Message-ID: <1413251832.21120.4.camel@concordia>
Subject: Re: [PATCHv9 2/5] ppc/cell: trivial: replace get_unused_fd() by
 get_unused_fd_flags(0)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yann Droneaud <ydroneaud@opteya.com>
Date: Tue, 14 Oct 2014 12:57:12 +1100
In-Reply-To: <9a145561123e28585d7994b61359a531128a80b8.1413223900.git.ydroneaud@opteya.com>
References: <cover.1413223900.git.ydroneaud@opteya.com>
 <9a145561123e28585d7994b61359a531128a80b8.1413223900.git.ydroneaud@opteya.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Jiri Kosina <trivial@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
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

On Mon, 2014-10-13 at 21:30 +0200, Yann Droneaud wrote:
> This patch replaces calls to get_unused_fd() with equivalent call to
> get_unused_fd_flags(0) to preserve current behavor for existing code.
> 
> In a further patch, get_unused_fd() will be removed so that new code
> start using get_unused_fd_flags(), with the hope O_CLOEXEC could be
> used, either by default or choosen by userspace.
> 
> Link: http://lkml.kernel.org/r/cover.1413223900.git.ydroneaud@opteya.com
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: trivial@kernel.org
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>

This is fine by me, do you want an ack, or do you want us to take it via the
powerpc tree?

If the former:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
