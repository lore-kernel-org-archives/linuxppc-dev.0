Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: iweiny@pacbell.net
Date: Thu, 26 Apr 2001 16:52:18 -0700 (PDT)
Subject: Kernel driver debugging
To: linuxppc-embedded@lists.linuxppc.org (linuxemb)
Message-id: <200104262352.QAA01767@batcave2.batcave>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am looking for the best way to debug kernel modules/drivers.

I am trying to get a PCI Audio Card (Creative SBLive) working just to do some
testing.  (ie don't want to spend a lot of time on PCI or this particular
card.)

In addition we would like to have a way to read registers and other values from
the hardware as we go forward.

What is the best solution?

Are there any good docs on-line for xmon, kgdb, and/or kdb?

I have also read about BDM4GDB and BDI2000.  Is BDI2000 worth the cost?  Are
there other BDM's for the 405 which work well with Linux?

Thanks again,
Ira Weiny
Digital Home Technologies


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
