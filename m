Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 70807DE02B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:00:40 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 15 Jul 2008 12:00:33 +0200
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: 2.6.26 does not boot on Pegasos
Message-ID: <20080715100033.GA5147@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi,

I just tried to boot 2.6.26 on a Pegasos and the kernel does not boot.
The last message I have is:
gunzip (0xffffffff <----- some more hex digits)

The configuration has been created from a working 2.6.25 one with
make oldconfig and answering N to new config options.

Anybody has seen this or do I have to start digging deeper?

	Regards,
	Gabriel
