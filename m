Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.0.20010816175113.00a4f0d0@pop.gmx.de>
Date: Thu, 16 Aug 2001 17:51:19 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: cross compiling 8xx glibc on x86
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:35 PM 8/15/2001 -0600, you wrote:
>I've spend two days scouring the postings here and read much as I can find
>on cross compiling
>glibc with no fpu options. I've read all kinds of things, compiled for
>hours, but nothing.  I've been somewhat unsuccessful,  I'm close to giving
>up but that's why I'm writing.

It took me two weeks until I gave up. This glibc is the trickiest part. I
wish Wolfgang would write one - oh, a subset is already in PPCBoot. :)


>I can compile glibc-2.2.3 (no mention of no fpu on configure) but bash segment
>faults (actually init respawns to fast). I can get bash running if I use
>the montavista compiled glibc* from their rpm. So I know that my
>kernel/filesystem works etc. But still I want to compile glibc for 8xx myself.

A statically linked bash should work, even with the cacheline bug.


>I get this error (I'm not the first one with this error,
>http://lists.linuxppc.org/linuxppc-embedded/200106/msg00178.html)

Yes it looks very much like the same. I asked again some time later. Here
is the reply that probably helps you:
http://lists.linuxppc.org/linuxppc-embedded/200106/msg00247.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
