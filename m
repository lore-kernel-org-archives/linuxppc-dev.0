Date: Fri, 11 Oct 2002 09:20:19 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon 7000 in 9500 - which slot?
Message-ID: <20021011092019.A1374@suse.de>
References: <20021010223212.A12862@suse.de> <20021010215943.24382@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021010215943.24382@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


begin  On Thu, Oct 10, Benjamin Herrenschmidt wrote:

> >we had this one before.
> >
> >pci_device_to_OF_node() returns null and you pass this to get_property()
>
> Where ? Can you elaborate ? inside radeonfb ? pci_device_to_OF_node
> should not return NULL, I though I fixed that...

Look in the first few lines of
arch/ppc/kernel/pci.c:pci_device_to_OF_node()
lots of return NULL; there ;)

OF doesnt init the card in some of the slots -> no OF properties.


Gruss Olaf

--
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
