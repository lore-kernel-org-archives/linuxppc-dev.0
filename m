Date: Thu, 8 Jul 2004 10:55:32 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: task utility
Message-ID: <20040708085532.GC12971@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <10524037.1089275683984.JavaMail.administrator@RnDserver>
Mime-Version: 1.0
In-Reply-To: <10524037.1089275683984.JavaMail.administrator@RnDserver>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> i want to know whether there exist any utility in hardhat-linux which
> can tell me the status of all processes running on my embedded system
> actually i am facing a strange problem of losing my task the kernel
> starts its threads but does not show the execution of task any other
> idea?

try to use punctuation it is much easier to read text for the people
receiving the e-mail capitals when you start a new sentence are in
general a good idea too :)

Is this what you are looking for (This is the description of a debian
pacakage)?

Package: ltt
Priority: optional
Section: devel
Installed-Size: 32
Maintainer: Yann Dirson <dirson@debian.org>
Architecture: all
Version: 0.9.5+really0.9.6pre3-5
Depends: ltt-tracer, ltt-visualizer
Recommends: kernel-patch-ltt
Suggests: ltt-dev
Filename: pool/main/l/ltt/ltt_0.9.5+really0.9.6pre3-5_all.deb
Size: 4734
MD5sum: d44058b682df9e06dde5a6b784cd97ee
Description: Linux Trace Toolkit - complete toolkit
 LTT is a kernel event tracer with low overhead.
 .
 LTT provides its user with all the information required to
 reconstruct a system's behavior during a certain period of time.
 One can know exactly the dynamics of a system.  Why do certain
 synchronization problems occur? What exactly happens to an
 application when a packet is received for it? Overall, where do all
 the applications that I use pass their time? Where are the I/O
 latencies in a given application? etc.
 .
 This package depends on tracing and visualizing tools.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
