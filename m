Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <69AB2E42243FD511920200805FE64EAD0E3616@ZBR01EXM01>
From: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: dynamically linked Init hanging 
Date: Tue, 16 Oct 2001 16:59:44 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang wrote:
>No, it cannot.
>
>The MPC8xx has no FPU, and a smaller cache line size.
>
>You need special libraries (with software floating point and  patches
>for the cache line size) for the MPC8xx.

That means that I need to rebuild all my glibc and gcc for the MPC8xx, right ?

And if I rebuild only the libraries of my /opt/target/lib directory and keep my hosts gcc/glibc configured for FPU and 32 cache line size. Do you think that I would be able to compile applications on host and run on target? I am asking that because I would like to have only one gcc/libc tools set on my host.

Thanks for you usual help and best regards

Evandro

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
