MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16562.39169.380795.528880@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 10:53:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org, debian-kernel@lists.debian.org
Subject: Re: minimum required binutils for ppc32?
In-Reply-To: <20040523095826.GA10105@lst.de>
References: <20040523095826.GA10105@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christoph Hellwig writes:

> What's the minimum required binutils version for ppc32 these days?

Whichever version is the first to handle the altivec instructions.

> The debian kernel package ups it from 2.12.1 to 2.12.90.0.7, i.e. from
> the first 2.12 maintaince release to one of hjl's later releases and
> I wonder why it does that.  Either it's bogus and should be be dropped
> or we should up it in mainline.

Seems bogus to me.

BTW, there is a recent change in binutils which make gas *not*
recognize the altivec instructions by default.  (This was to fix the
disassembler, go figure.)  We should probably add -many to ASFLAGS.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
