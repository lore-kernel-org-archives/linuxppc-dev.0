In-Reply-To: <001a01c48abe$0fccb5f0$0301a8c0@chuck2>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain> <000f01c48a95$e18e5c20$0301a8c0@chuck2> <FE902A72-F6AB-11D8-918A-003065F9B7DC@embeddededge.com> <001a01c48abe$0fccb5f0$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <60394D06-F6B8-11D8-918A-003065F9B7DC@embeddededge.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
Date: Wed, 25 Aug 2004 13:01:15 -0400
To: "Mark Chambers" <markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 25, 2004, at 12:10 PM, Mark Chambers wrote:

> http://www.finux.org/Reprints/Reprint-Bird-OLS2004.pdf

That's a very misleading paper, and if you read it carefully
actually supports what I said.

In total, XIP saved them about 80 mS, which is the time it
takes to copy a kernel to RAM.  Nothing else in the
paper is related to XIP.  You don't have to use a compressed
kernel in any environment, and most of the paper talked
about reducing other boot up delays.  the XIP is an
insignificant player in boot up time, it does have other
value as Wolfgang pointed out.

The kernel XIP from Flash isn't very hard to implement,
it is just very board configuration dependent.  All you
need is a proper linker command file for your board
and a couple of start up MMU hacks......for PowerPC.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
