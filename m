Message-ID: <3D1797C5.8080808@embeddededge.com>
Date: Mon, 24 Jun 2002 18:05:57 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: "David C. Chiu" <dchiu@ariodata.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Enlarging Kernel Stack (doesn't this question ever go away?)
References: <8A098FDFC6EED94B872CA2033711F86F0EC041@orion.ariodata.com> <20020624214255.GK3489@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Why are you trying to enlarge the stack?  This question never goes away
> since it's almost always wrong to enlarge the stack...

That's correct......you should be allocating space with vmalloc() and
just hanging on to a pointer that you vfree() later.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
