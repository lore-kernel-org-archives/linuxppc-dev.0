Message-ID: <3D179D11.3010009@embeddededge.com>
Date: Mon, 24 Jun 2002 18:28:33 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Enlarging Kernel Stack (doesn't this question ever go away?)
References: <8A098FDFC6EED94B872CA2033711F86F0EC044@orion.ariodata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David C. Chiu wrote:

> Thanks for the tip, however the problem isn't that we are allocating
> large stack variables but we have deeply nested calls...


Hmmmm.....Don't do that, then :-)  The stack plus thread structures
consist of two pages.  I don't know how many places may still assume
that in the code.  Due to both physical and virtual access to the pages,
I think they may also have to be physically contiguous (they used to be),
so you will have to allocate 4 pages as the next step.

Good Luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
