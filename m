Message-Id: <200007070607.IAA00742@piglet.grunz.lu>
Date: Fri, 7 Jul 2000 08:07:27 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: X still locks up
To: b.judd@xtra.co.nz
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000707142631.B804@thislove.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   7 Jul, this message from Gwyn Judd echoed through cyberspace:
> 3) When I rebooted there was no kernel panic in the logs. This has me
> puzzled. I suppose it could have crashed and not had it written out to
> disk in time. On the otherhand this has happened before and each time
> there is no panic.

If you want to be sure you get all panic logs, the only way is to get a
serial console. The console is the only device that is guaranteed to get
a panic log, if one is produced. You'd also see it on a (screen) console
if you weren't running X...

There's a doc explaining serial console under the linux/Documentation
directory.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
