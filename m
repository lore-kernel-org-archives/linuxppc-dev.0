Message-ID: <3C263AB9.1040105@embeddededge.com>
Date: Sun, 23 Dec 2001 15:12:41 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel BOOT (kernel 2.4.16)
References: <7746B3AB173A.AAA45B0@hermes17.si.c-s.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


LEROY Christophe wrote:


> I'm sure that it come here because when I add a call to m8xx_restart() just
> before the panic() call in mem_pieces_find(), the board restarts

Then something is wrong with the way your bootloader is telling the
kernel how much memory exists, although mapin_ram() should have
failed before you attempted any io mapping.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
