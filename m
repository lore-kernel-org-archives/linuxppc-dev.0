Date: Thu, 12 Sep 2002 11:24:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Delay on starting init
Message-ID: <20020912012457.GX13670@zax>
References: <20020911175118.04A9E38E9D@server.weathercom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020911175118.04A9E38E9D@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 11, 2002 at 12:34:54PM +0000, jim wrote:
>
> I pulled the lastest 2.4 devel tree from Monte Vista's mirror a couple of
> days ago and the behaviour of the boot process changed.  Now, the process
> pauses for a long time after the message; "Freeing unused kernel memory".  To
> make sure this was a kernel issue, I reverted to the previous kernel and it
> booted with no delay.  Also, the delay is apparent on both Hard Hat Linux 2.0
> and ELDK from Denx.
>
> Is anyone aware of what changed?

I've observed this as well, but I haven't tracked it down much.  When
I looked into it the delay seemed to be due to NFS delays and timeouts
(I'm using an NFS root), but that doesn't explain why it is so much
worse in recent 2.4 and (especially) 2.5.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
