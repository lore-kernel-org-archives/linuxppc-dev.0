Message-ID: <383993F5.BCE4A507@pplmail.com>
Date: Mon, 22 Nov 1999 14:05:25 -0500
From: Francois Guimond <fguimond@pplmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux ppc newbie boot sequense
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Excuse me for de obivious question, but I am a newbie...

I am trying to install a linux kernel on MPC8240 cpu in a limited flash
space.
(Motorola sandpoint evaluation platform 512kb flash 32MB ram and dink32
software)

I have got a PPC zImage compiled.

My question is what do I put at First Instruction?
Do I need Lilo?
Where is the first instruction of the kernel in a zImage?

I want only serial console first.

Because there is no CPM  in it, I wanted to postpone the networking
features.
It means no root over nfs...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
