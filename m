Message-ID: <396EEA5C.185284E2@wanadoo.fr>
Date: Fri, 14 Jul 2000 12:24:28 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
References: <200007140929.KAA03269@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> anyone know the magic keys to switch consoles on linuxppc?
> <alt>-fnX doesn't work for me...
> Iain.

Depending on your kernel, your configuration and the phase of the moon,
the <alt> key is sometimes the key labelled "alt" and sometimes the
"apple" key (aka "command"). And sometimes it is completely disabled.

In X, you use control-command-fnX, and on the i- and powerbooks you have
to press the keys in a certain order to make it work (first
control-command, then fn, then fnX, IIRC).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
