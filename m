Message-ID: <4033A0D7.1050005@jonmasters.org>
Date: Wed, 18 Feb 2004 17:28:55 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EDK6.1 vs. EDK3.2 clarification
References: <1036q23btu3ru01@corp.supernews.com>
In-Reply-To: <1036q23btu3ru01@corp.supernews.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

Added configuration options to Linux config.in to control (actual names
are slightly different for internal naming convention):

	CACHE_MODE	-	Toggle these
	CACHE_REAL	-	Real mode cacheing enabled
	CACHE_KERNEL	-	Kernel pages cacheing enabled
	CACHE_USER	-	User pages cacheing enabled

The system now boots if I disable all cacheing and it seems to be ok.
However this only partially helps me and I still welcome input.

Anyone know of any particular reason why this Memec Insight board would
dislike cacheing being enabled especially with EDK6.1 hardware?

I would love to hand validate the cache contents and this kind of thing
but the Xilinx documentation is not good. The Xilinx XMD FAQ says that
icachestartadr is a command when in fact it is a parameter to ppcconnect
and then fails to provide an actual example of its use. *Sigh*.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
