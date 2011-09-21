Return-Path: <greg@kroah.com>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E1721007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Sep 2011 00:08:24 +1000 (EST)
Date: Wed, 21 Sep 2011 07:06:23 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the tty tree with the powerpc tree
Message-ID: <20110921140623.GA19567@kroah.com>
References: <20110921150121.9f530384bc0bb6c2268fd9ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110921150121.9f530384bc0bb6c2268fd9ea@canb.auug.org.au>
Cc: Geoff Levand <geoff@infradead.org>, Andre Heider <a.heider@gmail.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2011 at 03:01:21PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the tty tree got conflicts in
> arch/powerpc/include/asm/udbg.h and arch/powerpc/kernel/udbg.c between
> commit c26afe9e8591 ("powerpc/ps3: Add gelic udbg driver") from the
> powerpc tree and commit dcd83aaff1c8 ("tty/powerpc: introduce the ePAPR
> embedded hypervisor byte channel driver") from the tty tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.

Thanks, that looks fine to me.

greg k-h
