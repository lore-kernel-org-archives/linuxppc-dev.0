Message-ID: <3DAC3828.5010005@embeddededge.com>
Date: Tue, 15 Oct 2002 11:45:44 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Laurent Mohin <laurent.mohin@acterna.com>
Cc: Ralph Blach <rcblach@us.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to change endian attribute for a memory region
References: <OF780A3997.14F8A90A-ONC1256C53.00523F95@eni.wago.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Mohin wrote:

> That was the purpose of my question. Has anybody written this IOremap_LE
> function?

If you are accessing this from a user space mapped frame buffer, it isn't
an ioremap() function but rather a generic Linux VM function.

Other platforms have solved this "problem" of mapping frame buffers,
perhaps you should be asking the question on the X server mailing lists.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
