Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01C1B608.E92871A0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Unbuffered char reads from App from stdin (keyboard)
Date: Fri, 15 Feb 2002 10:09:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


App and Linux kernel 2.2.13 running on mpc860T.

I would like to know the best way, from inside my GNU C App,
to sense if there's a keyboard key pressed.  Something
similar to kbhit() in Microsoft C.  I would like to have a particular
thread execute a loop continuously and only when a key
is present, do a getc() or getchar(), or gets(), and the like.

What is the best way to accomplish this?
Is there a way to make stdin unbuffered?

Thanks,

ShutEyeThinkin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
