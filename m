Return-Path: <dbruce@ll.mit.edu>
Received: from ll.mit.edu (LLMAIL.LL.MIT.EDU [129.55.12.40])
	by ozlabs.org (Postfix) with ESMTP id 1B94D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 02:29:27 +1000 (EST)
Received: (from smtp@localhost) by ll.mit.edu (8.12.10/8.8.8) id j2SGTOT0013054
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Mar 2005 11:29:24 -0500 (EST)
Message-ID: <424830D3.4020000@ll.mit.edu>
Date: Mon, 28 Mar 2005 11:29:07 -0500
From: David Bruce <dbruce@ll.mit.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050325221320.004DC67AB2@ozlabs.org>
In-Reply-To: <20050325221320.004DC67AB2@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Question regarding Interrupt "delivery" to user mode process
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The below link contain code snippets that process SONET events via an 
interrupt. Basically an user space application waits on an ioctl call 
for events that are queued. These events are queued via a kernel thread 
that waits on a wait_event_interruptible call. When an interupt happens 
the thread processes the events, timestamps them and puts a message on a 
queue.

There is other code that is left out the starts the thread. If you are 
interested...ask.

http://www.geocities.com/dbruce_01721/event.c
