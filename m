Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 25 May 2005 11:30:51 +1000
Message-Id: <1116984651.6395.60.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As the subject says ... it's the source of endless headaches, is used in
a way that often prevents moving TASK_SIZE freely, etc etc etc...

What are the good and unavoidable uses of it currently that cannot be
replaced by some sort of ioremap ?

(Note that if the answer to the above is: page tables exist too late, I
already have a reply: our initialisations happen too early, let's move
things around so that ioremap is useable... pretty much everything
needed to setup kernel page tables & have working ioremap can be done
without any HW device access so ...)

Ben.
