Message-ID: <3ED497D6.2070902@embeddededge.com>
Date: Wed, 28 May 2003 07:04:54 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PATCH: arch/ppc/8xx_io_fec.c
References: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com> <20030527165824.GG3453@ip68-0-152-218.tc.ph.cox.net> <3ED3BDA0.3030208@embeddededge.com> <20030527201343.GM3453@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> How would you suggest working around both this problem, and the problems
> that Jean-Denis reported?

I understand the problem that needed to be fixed, and that was done.
It seems quite a few people have been making changes do this driver,
logic has been copied around and some of it doesn't make sense.

In your usual, "send me lots of patches" mode, there should have been
one to fix the real problem, and another to do "clean up." :-)

>>The code formatting looks like crap, so that needs to be fixed.
>
>
> That's trivial 'tho. :)

If you have time to do it, that's fine.  I don't :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
