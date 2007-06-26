Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59A0FDDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 15:53:13 +1000 (EST)
Date: Tue, 26 Jun 2007 07:52:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] Remove JPROBE_ENTRY()
Message-ID: <20070626055236.GA6841@lst.de>
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<98c8ff25191ced991066092ffd4899526097da1e.1182822366.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98c8ff25191ced991066092ffd4899526097da1e.1182822366.git.michael@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 11:48:51AM +1000, Michael Ellerman wrote:
> AFAICT now that jprobe.entry is a void *, JPROBE_ENTRY doesn't do
> anything useful - so remove it ..
> 
> I've left a do-nothing version so that out-of-tree jprobes code will still
> compile without modifications.

Please kill the definition.  We don't want to keep unused crap around
just to let code compile.  And I have some plans for even deeper change
in this area, so they'll have to change anyway.
