Message-Id: <200012220714.IAA00726@piglet.grunz.lu>
Date: Fri, 22 Dec 2000 08:14:37 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ethernet issue with lombard
To: huber@mclx.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001219220143.C6309@missioncriticallinux.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Dec, this message from Josh Huber echoed through cyberspace:
> I can kill the network easily with ping -f <ip of local host>

Ping _from_ local _to_ local? I believe that doesn't even go to the
ethernet interface, but is returned right in the IP stack. At least, for
me, I don't get _any_ sort of network activity when ping -f'ing on local
IP address....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
