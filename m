Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <69AB2E42243FD511920200805FE64EAD0E3611@ZBR01EXM01>
From: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: dynamically linked Init hanging
Date: Tue, 16 Oct 2001 14:55:18 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have been booting my FADS860T board using Denx 2.4.4 kernel and Monta Vista CDK as NFS root file system. It works ok.

Now, I would like to use a PowerPC based machine running LinuxPPC as host in order to use the native gcc, libs, and the application binaries instead of cross-compiling those.

I created a /opt/target directory to be exported as NFS and then I copied the libs and applications from the /lib, /bin and /sbin directories of the host to the /opt/target/lib,bin,sbin directories.

The Kernel is booting ok but the boot process is hanging on Init process.
I gess the problem is on glibc, because I tried using a statically linked Init and I got some progress (actually, the problems was postponed to the moment when the init scripts tries to run any application).

Does any one know if glibc-2.1.3 from Linux/PPC 2000 Q4 can be used on a MPC860 target?
If yes. Does any ones have any clue?

Thanks in advance and regards

Evandro


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
