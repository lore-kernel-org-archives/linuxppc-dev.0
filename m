Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D5B82BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 04:50:55 +1100 (EST)
In-Reply-To: <20050114161609.37891.qmail@web53805.mail.yahoo.com>
References: <20050114161609.37891.qmail@web53805.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CAEA499A-6654-11D9-9846-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 14 Jan 2005 12:50:35 -0500
To: annamaya <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK on a PowerPC host machine? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 14, 2005, at 11:16 AM, annamaya wrote:

> Thanks for the reply Wolfgang. Can you give me a hint
> on the kind of work that is required to make this work
> for the PPC host?

I do all of my development on PowerPC hosts because
I don't have anything else.  I regularly build compiler
tools to work in a "cross" environment, mainly to ensure
consistency of target binaries and libraries.  I'd be happy
to work with anyone that wants to rebuild ELDK for
YDL 3.x hosts.

If someone wants to use MVL 3.1 in such an environment,
we can discuss that, too.

Of course, if you have a PowerPC host, you can just cheat
in most cases and use the host tools.  This won't work for
such things and 8xx or 85xx SPE, but it would get you
started.

	-- Dan
