Message-ID: <3DF0D6B6.2050307@embeddededge.com>
Date: Fri, 06 Dec 2002 11:56:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <3DF0A4D9.4030603@intracom.gr> <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se> <20021206085909.B17918@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

 > ....  If you
> want the kernel virtual address then you can apply __va to that.

Errr....no, you can't.  That would give you the cached mapping.
You need to hang on to both the dma_handle (the phys address token)
and the virtual address returned by the function.  That's why both
are returned.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
