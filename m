Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46610B7714
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:29:08 +1100 (EST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5F3E521381
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 11:29:05 -0400 (EDT)
Date: Fri, 16 Mar 2012 08:29:03 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the char-misc tree with the powerpc
 tree
Message-ID: <20120316152903.GG28696@kroah.com>
References: <20120316165207.5a4f0985863b5ae7c50bdd81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120316165207.5a4f0985863b5ae7c50bdd81@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Masanari Iida <standby24x7@gmail.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2012 at 04:52:07PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in
> drivers/char/viotape.c between commit ba7a4822b48f ("powerpc: Remove some
> of the legacy iSeries specific device drivers") from the powerpc tree and
> commit 5fb15db4376f ("char: Fix typo in viotape.c") from the char-misc
> tree.
> 
> The former removed this file, so I did that.

Sounds good to me, thanks.

greg k-h
