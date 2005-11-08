Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 90C8C686A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 22:59:38 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 08F1229EBC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 12:57:54 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30792-07 for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 12:57:53 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 4191C29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 12:57:53 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 8 Nov 2005 13:59:26 +0200
References: <20051107151011.GA17161@logos.cnet>
	<b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
In-Reply-To: <b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511081259.26525.david.jander@protonic.nl>
Subject: Re: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 08 November 2005 01:55, Dan Malek wrote:
> On Nov 7, 2005, at 10:10 AM, Marcelo Tosatti wrote:
> > The following is an attempt to fix swapping on 8xx by not touching
> > _PAGE_ACCESSED bit if the page is not present.
>
> Ugh ....  I suppose.  I hate assembler code macros .......
> Somehow, "swapping" and "8xx" just don't belong together.

Well, at least it sounds ugly together, but it is also at least conceiveable. 
There seem to be people who use PCMCIA for an IDE interface, so swapping may 
become desireable in some cases.

> I'm tempted to add a configuration option that is the complete
> opposite of this and assumes are really embedded system.
> Mark pages as always accessed, data pages as always dirty,
> and you can eliminate lots of TLB faults in systems that are
> fairly static.

It sounds tempting indeed, but should you really notice a performance increase 
out of this?

Greetings,

-- 
David Jander
