Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id BE9FE67A73
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 21:53:01 +1000 (EST)
Date: Tue, 30 May 2006 13:23:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: Linux kernel thread with Linux 2.6.x
Message-ID: <20060530112343.GB24129@wohnheim.fh-wedel.de>
References: <82ecf08e0605291013t7bd1627bg92d13908b3d0b7b7@mail.gmail.com>
	<000a01c683cd$e3f29ca0$5201a8c0@GEG2400>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <000a01c683cd$e3f29ca0$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 30 May 2006 11:46:09 +0200, Laurent Lagrange wrote:
> 
> Thanks for your answer, but a tasklet runs in interrupt context
> (in_interrupt() != 0) so it doesn't support schedule() call
> included in "down" semaphore function.

Do you have code you can show?

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
