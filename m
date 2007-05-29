Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1923DE032
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:38:50 +1000 (EST)
In-Reply-To: <40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 16:38:45 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But we can't do that any more since the architecture specifically
> allows for the 'upper bits' not to have valid data in them.

That's not PowerPC, that's BookE ;-P  If what you're
saying is true in the 2.03 POWER ISA, even for server
class implementations, that would be very unfortunate.

Or perhaps you misread, there are a few insns that
have undefined results in the high half word.  Could
you give a reference please?

If you mean Book I 1.5.2, that is for embedded class
(i.e., BookE) CPUs only.


Segher
