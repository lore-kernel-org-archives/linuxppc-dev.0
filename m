From: Benjamin Herrenschmidt <bh40@calva.net>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem in GMAC ?
Date: Fri, 6 Oct 2000 21:25:00 +0200
Message-Id: <19340831125644.26889@192.168.1.10>
In-Reply-To: <39DDC5F7.5468358@rd.francetelecom.fr>
References: <39DDC5F7.5468358@rd.francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I think there are a small probleme in gmac drivers.
>The size of received packet is not substracted by
>CRC length. You can see that with ethereal on all Linux machine.
>Then minimum packet is 64, but it must be 60.
>And you can see that all packet is 4 bytes too long.
>
>Is it normal or not ???

That's quite possible, I was not too sure what to do about it ;)

I beleive I should just substract 4 from the size of all Rx packets. This
problem have biten MOL too lately.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
