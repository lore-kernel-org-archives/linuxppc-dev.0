Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CC7F018.2040604@dgt-lab.com.pl>
Date: Thu, 25 Apr 2002 14:01:28 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: console on SCC1 on 8260
Content-Type: text/plain; charset=windows-1250; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Huh, I've just discovered that arch/ppc/8260_io/uart.c does not support
 console on SCC1!
Anyone has such version of this driver?

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
