Date: Mon, 27 May 2002 16:34:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: map iomem in linux_2_4_dev
Message-ID: <20020527063451.GL16537@zax>
References: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 01:59:54PM +0800, shaowei dai wrote:
>
> Hello, every one:
>
> I've searched through the achieve, but failed to find stuff about mapping
> io-memmory in this linux_2_4_dev version.
> After check the source code, it seems from 2_4_dev onwards, no need to use
> ioremap to map io memory. We
> should use io_block_mapping() instead.

No, you should use ioremap() wherever possible.  Only use
io_block_mapping() if for some strange reason you need to specify the
virtual address.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
