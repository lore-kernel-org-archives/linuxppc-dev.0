Message-ID: <3D3238E0.5090306@embeddededge.com>
Date: Sun, 14 Jul 2002 22:52:16 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: akuster@dslextreme.com
Cc: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] ppc4xx_pic
References: <3D31F6B2.3010900@dslextreme.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


akuster wrote:

> Basicaly I check to see if a table exists and if so, update the
> interrupt controller during ppc4xx_pic_init with the proper values.
> Since the on-chip devices are all ready setup by the bootrom or at
> least we have been assuming this is the case ,  I am not going to worry
> about them.

My only suggestion is to make the table always exist (removing the
"if it exists" option), and to represent all interrupts (like openpic
does).  It may make the rest of the supporting software easier to
write and will serve as a source of documentation for what the boot rom
may configure. :-)

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
