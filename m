From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gopi krishna <mgopik@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Unable to read/write consistently to a device.
Date: Tue, 27 Feb 2001 20:27:29 +0100
Message-Id: <19350122125913.1459@smtp.wanadoo.fr>
In-Reply-To: <20010227170238.55737.qmail@web11103.mail.yahoo.com>
References: <20010227170238.55737.qmail@web11103.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  We have a device 0xf0040000.  This address has been
>ioremapped.
>(Hence directly using the physical address to access
>the memory)

What do you mean by ioremapped ? You should use the virtual address
returned by ioremap (which is usually _not_ the same as the physical
address, except in some specific cases), not the physical address, to
access the registers.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
