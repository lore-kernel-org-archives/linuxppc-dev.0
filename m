Message-ID: <3BEAFBCE.5000702@embeddededge.com>
Date: Thu, 08 Nov 2001 16:40:30 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
References: <20011108193006.26A0010028@hostme.bitkeeper.com> <20011108123809.C1700@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:


> I was thinking about this a bit.  The problem is that we have multiple
> types of serial controllers we need to 'init' some how.

This is because I tried to use the same functions across a wide variety
of boards.  All we need to do is define a macro in a board specific
file someplace that calls the proper init function.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
