Message-ID: <382FDE6B.4A758279@schweiz.ch>
Date: Mon, 15 Nov 1999 11:20:38 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: kernel 2.3.27/28 ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

has anybody had success with a kernel 2.3.27/28 on a PowerMac?
I can build both after some modifications in driver/net/setup.c. But it
doesn't boot. It hangs with saying 'booting...' On a 7200 and on a
wallstreet I.
A 2.3.26 I got to boot. But now I don't know where to look for the boot stuff.
When hanging in the beginning, which part of code is responsible for
that? Is it in pmac_setup init etc? 

Thanks for any hint.


Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
