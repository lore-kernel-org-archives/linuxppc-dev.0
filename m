From: Benjamin Herrenschmidt <bh40@calva.net>
To: Robert Thompson <rothomp3@vt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.17pre9-ben1 and airport
Date: Fri, 7 Jul 2000 23:17:36 +0200
Message-Id: <20000707211736.17390@192.168.1.10>
In-Reply-To: <002e01bfe854$c4019c40$1a6a1504@strayer.edu>
References: <002e01bfe854$c4019c40$1a6a1504@strayer.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>2.) When I try to insmod airport.o network_name=home it claims that printk
>and isa_io_base are unresolved symbols.

Did you enable the module versionning option in the kernel config ? This
may cause problems with the airport module.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
