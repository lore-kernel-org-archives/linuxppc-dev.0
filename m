Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E2D751C.7000001@devcom.cz>
Date: Tue, 21 Jan 2003 17:28:12 +0100
From: Jan Damborsky <Jan.Damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with data cache on MPC823E
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello people,

we have developed our board with MPC823E, FLASH memory
DRAM memory for embedded Linux porting, but we have problem
with data cache. From time to time when CPU wants load data from DRAM
to data cache, it makes four burst-reads instead of one for loading one
cache line.
After this, all four words in cache line are loaded with the same first
"critical word".
We don't know, why CPU repeats this burst-read four times. May be it is
because we have floating BI (burst inhibit) CPU singnal.
We have set BIH bit in UPMA to zero.
When setting this BIH bit to one (burst inhibit), all works well.
Does anybody have any help ?
                                                     Jan Damborsky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
