Message-ID: <20010820191655.27820.qmail@web20105.mail.yahoo.com>
Date: Mon, 20 Aug 2001 12:16:55 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Re: Using IDMA1 ( or IDMA2 ) on 860
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B802482.80086FC8@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

>
> > /* version2 of GetChipAddress this WORKS why? */
>
> Because you can't directly access physical bus
> addresses from
> the kernel.  They have to be mapped to some virtual
> address.
> The IMMR is mapped to a well known address that can
> generally
> be used anywhere in the kernel.  Anything else must
> be mapped,
> as your example shows.  Just make sure you do this
> _once_,
> don't keep calling ioremap() over and over or you
> will exhaust
> the VM space and get a different address every time.
>
>
> 	-- Dan

Thanks for all your help and education. One last
question on this, if I have a pointer that is returned
by doing ioremap_noncache() if I want to assign this
pointer in buffer descriptor setup should i be doing
__pa () correct? Will __pa() translate that address
back to the actual physical address?

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
