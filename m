Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C6BF3B1.2040906@capflow.com>
Date: Thu, 14 Feb 2002 18:28:17 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCC or SMC for console ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I'm developping a board based on a MPC860T.

I need 4 serial ports at runtime, and was wondering if I should rather
use 2SMC + 2SCC or 4 SCC (or 1SMC + 3SCC).

I need a console, but no hardware flow control (which would force the
use of SCC).

Thanks for your help.

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
