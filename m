Date: Mon, 29 Jan 2001 14:39:01 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: correct use of lock_kernel() - help!  please
In-Reply-To: <20010129112448.C96802EFBD@apollo.valhalla.net>
Message-ID: <Pine.GSO.4.10.10101291435080.899-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 29 Jan 2001, Iain Sandoe wrote:

> Around the use of which kernel resources should a lock be applied?

Depends on the resource, but most of it shouldn't need this anymore. If
the kernel lock is moved into the driver, it usually means that everything
else is safe, check now that the driver itself is smp safe, then you can
remove the kernel lock.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
