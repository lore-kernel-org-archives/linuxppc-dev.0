In-Reply-To: <1074890984.2840.25.camel@otta.rchland.ibm.com>
References: <20040123111725.GB23537@iliana> <1074883450.2842.9.camel@otta.rchland.ibm.com> <20040123185433.GB5125@iliana> <1074890984.2840.25.camel@otta.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <897BA5DA-4FD4-11D8-99B7-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Sven Luther <sven.luther@wanadoo.fr>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: chrp mmu and booting.
Date: Mon, 26 Jan 2004 08:52:06 +0100
To: Peter Bergner <bergner@vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Yes, you can boot any 32-bit ELF binary from OF.  Yaboot and the zImage
> wrapper for the 64-bit kernel are both 32-bit ELF binaries, so you can
> boot either of these.  Note that you cannot boot a plain PPC64 vmlinux,
> as the OF ELF loader doesn't support 64-bit ELF binaries.

This is OF implementation dependent -- for example, the Apple one will
load 64-bit ELF just fine (iirc).


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
