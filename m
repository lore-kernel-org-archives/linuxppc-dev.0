From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Olaf Hering" <olh@suse.de>
Cc: "Stefan Jeglinski" <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Radeon 7000 in 9500 - which slot?
Date: Thu, 10 Oct 2002 23:59:43 +0200
Message-Id: <20021010215943.24382@192.168.4.1>
In-Reply-To: <20021010223212.A12862@suse.de>
References: <20021010223212.A12862@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>we had this one before.
>
>pci_device_to_OF_node() returns null and you pass this to get_property()

Where ? Can you elaborate ? inside radeonfb ? pci_device_to_OF_node
should not return NULL, I though I fixed that...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
