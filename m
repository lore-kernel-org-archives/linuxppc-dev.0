From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
Cc: <rwaldrop@sbcglobal.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: aic7xxx breakage
Date: Sun, 11 Aug 2002 10:41:24 +0200
Message-Id: <20020811084124.10190@192.168.4.1>
In-Reply-To: <20020811055718.59ebc9bd.billfink@mindspring.com>
References: <20020811055718.59ebc9bd.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Unfortunately, with this change the kernel doesn't even boot, failing
>very early on with the last messages on screen being:
>
>openpic enter
>openpic timer
>openpic ext
>openpic spurious
>openpic exit

Ok, boot that kernel with the "printkbtext" kernel arg and tell me what
it says.

Thanks

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
