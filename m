Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <200201022111.QAA18195@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
Date: Wed, 02 Jan 2002 16:11:10 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The ppc64 port has an array of virtual irq's which is used to index to
>the real irq.  In the interests of easy debugging (eg when drivers print
>out their irq number) the virtual irq is kept identical to the actual
>whenever possible.
>
>arch/ppc64/prom.c sets up the map (virt_irq_to_real_map), and
>arch/ppc64/xics.c (the interrupt controller) uses it.


Simple translation of irqs doesn't really solve the
problem; a general solution would provide us with the
ability to initialize and service interrupt requests
routed through multiple, nested, heterogeneous
controllers no matter what the HW designers were
smoking when they laid out the system.  See earlier
posts to this list for good discussion on this topic.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
