Date: Thu, 23 Aug 2001 18:59:11 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: get_cycles/get_tbl on 405
Message-ID: <20010823185911.A3291@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wanted to do some quick time measurements of some things on a driver
running of the 405GP and I eneded up using get_tbl(). It seems like
get_cycles should be the more standard way to get a tick count but
it seems to return 0. I don't get the __ftr_fixup stuff in timex.h
so I am not sure what it is trying to do differently from get_tbl.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
