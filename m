Message-ID: <20010906175743.3218.qmail@web20103.mail.yahoo.com>
Date: Thu, 6 Sep 2001 10:57:43 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: IDMA freezes but with periodic printk() things work...
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am faced with very strange problem.

I have IDMA channel 1 that I am using to send
ethernet packets to external device. What I have seen
is if I try to transmit large amount of data at really
fast rate things IDMA transfer simply stops. However
if I do printk() after say every 10000 byte transfer
IDMA tranfer code works for days.

Has anybody seen this kind of behaviour before? What
are the possible reasons this might happen?

Any hints!!

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
