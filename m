Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51A98DDE23
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 06:47:38 +1000 (EST)
Date: Sat, 13 Oct 2007 21:47:31 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] missing includes in arch/powerpc/platforms/52xx/lite5200.c
Message-ID: <20071013204731.GN8181@ftp.linux.org.uk>
References: <20071013184008.GL8181@ftp.linux.org.uk>
	<fa686aa40710131335y710cf6edy59a46d365b1d6d67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710131335y710cf6edy59a46d365b1d6d67@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 13, 2007 at 02:35:26PM -0600, Grant Likely wrote:
> On 10/13/07, Al Viro <viro@ftp.linux.org.uk> wrote:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Nak, this patch should be used to fix it instead.  A change to
> lite5200 got dropped during merging.
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=14077

Fine by me.
