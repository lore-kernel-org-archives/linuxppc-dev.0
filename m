Message-ID: <3C2CA87E.3060105@embeddededge.com>
Date: Fri, 28 Dec 2001 12:14:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
References: <0111281640.AA27241@ivan.Harhan.ORG> <3C0527AF.9CA07809@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Armin Kuster wrote:


> AFAIK your board header should go in include/asm-ppc/platforms and your
> board.c file should go arch/ppc/platforms

Which is of course true today but a big change from the way the kernel
has evolved.  We used to put all of the include files (or others) that
were unique to a platform (or unused outside of the kernel) together
in lower level directories.  Just a bit of trivia so eveyone understands
why it was done the "old" way and why it may be hard to change to the
"new" way :-).


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
