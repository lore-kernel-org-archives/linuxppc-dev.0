Message-ID: <3C0EC2E2.4020208@acm.org>
Date: Wed, 05 Dec 2001 18:59:14 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <3C0E48D2.6000409@acm.org> <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

>
>I think the reason this wasn't applied is that Paul said something about
>thiws being horriyingly ugly.  Corey, can you post a patch that changes
>RELOC(x) into a function and nothing else? :)
>
My original patch has the function.  I prefer the macro, it may be a
little uglier but it removes a dependency between the include file and
the source.  It needs to be commented though, the reason for it's
wierdness is not really clear.

-Corey


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
