Message-ID: <3D6DB30E.6060509@embeddededge.com>
Date: Thu, 29 Aug 2002 01:37:18 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: caokai <tk19@taikebj.com.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx's IMMR can not be 0x12200000?
References: <3D6D7B65.DC29B971@taikebj.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


caokai wrote:

>      But if I set IMMR to 0xFF000000, the linux kernel can work good.
>      I think this limitation must be somewhere in the
> arch/ppc/kernel/head_8xx.S.right?

It's a requirement to be mapped at a very high address like this for
the kernel to work properly.  This is due to the early memory mapping
required by the kernel to access devices in this space.  There is lots
of discussion about this if you search the e-mail archives and FAQs.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
