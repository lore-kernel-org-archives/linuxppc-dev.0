Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9164967A7D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2005 13:02:56 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je64zk5x56.fsf@sykes.suse.de>
References: <jed5tuqlp1.fsf@sykes.suse.de>
	<1111377588.3835.258.camel@gaston> <jey8che16m.fsf@sykes.suse.de>
	<1111407779.1236.272.camel@gaston> <je8y4g7m6h.fsf@sykes.suse.de>
	<1111447381.1236.295.camel@gaston>  <je64zk5x56.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 13:01:34 +1100
Message-Id: <1111456894.25180.320.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Wakeup broken on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-22 at 01:42 +0100, Andreas Schwab wrote:

> I have no idea how to put it into sleep in this configuration.  The
> pbbuttonsd says that sleep is not supported.

You need "snooze" and do "snooze -f", but I think the L1 cache flush is
the culprit, I'll try to find a solution.

Ben.
