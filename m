Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_5 source tree (and others)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 May 2001 18:38:02 +1000
Message-ID: <21780.989483882@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I see that the linuxppc_2_5 bk tree has disappeared from fsmlabs, and
has been replaced with a linuxppc_2_4_devel tree. Could someone in the
know please post a quick update what this means, and perhaps what the
future holds wrt 2.4/2.5 linuxppc (embedded)?

I guess I should actually ask about what I want :-) The linuxppc_2_5 tree
had a "drivers/i2c/i2c-algo-8xx.c" file which has disappeared from 2_4_devel.
I need an i2c driver for linuxppc for the 8260 and figured this would be a
good place to start. So the question really is what has happened to the 8xx
i2c driver in the fsmlabs linuxppc_2_5, and has anyone ported this to (or done
one independently for) the 8260?

And while I am at it, I have searched the archives for info about IDMA
and it appears that it is a do it yourself job (and that it may not be
so good on the 8xx anyway - but from what we can tell, it is much better
on the 8260 - if anyone knows differently, please let me know). If you
have a driver/support code/etc for IDMA on the 8260 (or 8xx) I would
appreciate it very much if you let me know.

Thanks for your time. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
