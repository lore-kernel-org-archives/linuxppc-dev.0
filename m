From: Benjamin Herrenschmidt <bh40@calva.net>
To: <bob@kunk.jriver.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test10 benh/SMP/spin_trylock
Date: Mon, 20 Nov 2000 21:10:06 +0100
Message-Id: <19341015134150.13225@192.168.1.2>
In-Reply-To: <20001120194101.4419.qmail@kunk.jriver.com>
References: <20001120194101.4419.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>If CONFIG_SMP is not set for the benh devel tree, the ppp_async.c
>file will have an undefined spin_trylock.

Fixed in the current bitkeeper linuxppc_2_3 tree.

None of my rsync tree is currently active. All the important stuff (with
one small exception that should not be important for you) have been merged
in the main trees (linuxppc_2_2 and linuxppc_2_3), including stuff that
was previously only in linuxppc_2_5.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
