Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 26 Jan 2004 11:43:01 +0800
Message-Id: <200401261143.AA942145714@actinium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Arun Kumar" <arunkumar@actinium.org>
Reply-To: <arunkumar@actinium.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <linuxppc-devel@lists.linuxppc.org>
Subject: RE:/dev/null
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am new to this field.
I am trying to get bootloader for MPC8xx board.
I am downloading from ELDK and i got eldk-ppc-linux-x86.
When I am trying to get the eldk_build file from cvs of denx.de site Iam getting that open /dev/null failed.
so it is coming out without getting the file.

How to open this /dev/null file.
In /dev directory the null files exists and having with permissions 0666.But the problem is that it is not recognising in current home directory or /opt/eldk file (where I want to build files).

Even though I am downloading as a root the problem exists and I tried to make a hard link between /dev/null and /op/eldk/dev/null(which i created /dev/null seperately in this /opt/eldk). The same problem persists.

Help in this regard so that I can proceed further in my project.

Thanks in advance,
arunkumar@actinium.org.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
