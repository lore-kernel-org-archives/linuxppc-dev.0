Message-ID: <3857E6CC.2D99B69C@netx4.com>
Date: Wed, 15 Dec 1999 14:06:52 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
CC: bsimon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:


> Other potential problem, which has bitten me, is to
> make sure you don't have any lines locked in cache
> before you jump to the kernel loader.


This is all part of the documented steps necessary to
properly initialize the 8xx after power up........things
a boot rom should perform.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
