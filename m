Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 21 Mar 2001 17:57:58 -0500
From: "John F. Davis" <davis@skink.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ramdisk size using montevista
Message-ID: <20010321175758.A7228@skink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am trying to boot hardhat linux with a small ram disk.  However, libc is more
than 4 megs by itself.  Is there something obvious I can do/read?  I tried using
busybox, but that only makes the bin directory small.  I don't really know
what I should do about the /lib directory.

John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
