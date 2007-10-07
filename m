Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 189B7DDEFC
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 23:58:01 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sun, 7 Oct 2007 06:50:37 -0700
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] PPC: Remove redundant reference to non-existent
	CONFIG_BOOTIMG.
Message-ID: <20071007135037.GA4422@xyzzy.farnsworth.org>
References: <Pine.LNX.4.64.0710070731410.32762@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0710070731410.32762@localhost.localdomain>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 07:34:57AM -0400, Robert P. J. Day wrote:
>   there is, AFAICT, no BOOTIMG Kconfig variable.  not to mention that
> there is no such include/linux/bootimg.h header file.
> 
>  arch/ppc/platforms/ev64360.c |    3 ---
>  arch/ppc/platforms/katana.c  |    3 ---
>  2 files changed, 6 deletions(-)

Ack.  Bootimg is long gone.

-Dale
