Message-ID: <3D6C63B6.8050508@embeddededge.com>
Date: Wed, 28 Aug 2002 01:46:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Misc 8260 fixes/options
References: <200208271710.10344.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

> +#define _128KB			(128*1024U)
> +#define _256MB			(256*1024*1024U)
> +#define is_size_ok(x)		(!((x) < _128KB || (x) > _256MB))

I don't believe this is correct for all PowerPC processors that have BATs.
Can you verify this and ensure it works on everything?  I know 601s have
different sized BATs, and the caller of this function really needs to know
what they are doing to ensure this works correctly.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
