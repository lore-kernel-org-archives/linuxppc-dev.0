Message-ID: <3D404F83.8010308@embeddededge.com>
Date: Thu, 25 Jul 2002 15:20:35 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Cort Dougan <cort@fsmlabs.com>,
	Matthew Locke <mlocke@mvista.com>, akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <20020725105336.F2276@host110.fsmlabs.com> <20020725162026.19919@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:


> Well, while I tend to agree with you on this, experience proved that
> slightly abusing the ppc_md. indirection somewhat helped make the
> code cleaner (read: more self-contained, less cruft, ...)

All of the architectures except PowerPC seem to have a indirect
pointer to a power saving idle function from the idle loop.  If
you don't want to follow this, we could have all of the board
specific files contain a 'power_save()' function, which could be
empty, always compile it and always call it.  Today, the power
saving stuff is all 6xx/7xx/Mac specific, which kinda needs to
change if we want address the needs of embedded processors and
products.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
