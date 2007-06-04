Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:34 +1000
Subject: [PATCH 0/21] This is my pending series for 2.6.23
Message-Id: <1180934134.603289.870346178920.qpush@grosgo>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It contains 

 - My PCI IO allocation rework (the first patch changes generic code
   and is in -mm already)

 - spufs single step & capabilities support

 - my cleanup/merge of the ptrace code

 - patches from Christoph Hellwig and myself that fix and merge things
   in the signal handling code

I'm still working on saving the top 32 bits of registers on 64 bits
for signals, so that's not included here.
