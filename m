Message-Id: <200007081623.RAA32155@hyperion.valhalla.net>
Date: Sat, 08 Jul 2000 17:23:20 +0100
Subject: Sys Call Numbers
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I did a patch to allow Jun Sun's IRQ Latency testing code to be used on
2.2.17pre7 et. al.

Today I came to apply it to Ben H's pre10 - to find that the sysCall number
Jun had used was no longer 'available' (listed as MacOnLinux use).

Is this just a 'hazard' or is there some way of knowing where to allocate a
syscall number.

(It's not a big point - there's only one #define to change - but, then
again....)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
