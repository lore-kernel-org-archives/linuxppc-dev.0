Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 9E90A67A07
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 01:43:40 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: frequent sig 11 with malloc() on mpc8xx
Date: Thu, 4 May 2006 17:46:31 +0200
References: <20060504144605.B18B3353BE7@atlas.denx.de>
In-Reply-To: <20060504144605.B18B3353BE7@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605041746.31645.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 04 May 2006 16:46, Wolfgang Denk wrote:
> Ummm... I have yet to see a single case where moving to 2.6  improved
> the stability for a MPC8xx system :-(

Our case.

Jffs2's gc thread stopped crashing. This might have more to do with mtd/jffs2 
than with the rest of the kernel, but it sure works better now.

Nevertheless I am very interested in hearing about (potential) stability 
problems with with 2.6.14, 15 and 16 (besides not booting just because 
Marcelo couldn't resist screwing up on the last minute; problem which is 
being worked on ;-).

Greetings,

-- 
David Jander
