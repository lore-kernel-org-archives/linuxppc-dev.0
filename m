Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 20 Feb 2003 14:27:03 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bringing up Motorola MGT5100
Message-ID: <20030220142703.A24949@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working on bringing up Linux on a Motorola MGT5100 board.  It's
core is roughly a 603e, with lots of other devices on the chip.

I am using an Abatron and have a question about really early boot.
When the MMU is first turned and we are executing at 0xC-bazillion the
Abatron can't read the contents of those addresses.  Is this a dark
time when the Abatron isn't expected to be able to read that memory,
or do I have the MMU or Abatron set up wrong?  (I can single step and
put hardware breakpoints up there.)

Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
