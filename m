Message-ID: <3F0C8B36.9040907@mvista.com>
Date: Wed, 09 Jul 2003 14:37:58 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: torben@kernel.dk
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using current dev kernel with Npe405L,
References: <20030709123600.GA4255@tmathiasen>
In-Reply-To: <20030709123600.GA4255@tmathiasen>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


torben@kernel.dk wrote:
> Hi,
>
> I was wondering what the status of Npe405L support is in the current
> linux-2.4ppc-devel kernel? I see some 405L specific code in the tree but it
> looks to only be the initial support.

I believe it has the about the same level of support as many other ppc
405's, most of the hardware is supported.

> Also, how compatible are the the 405L to the 405GP? Is it possible to boot a
> kernel compiled for the 405GP (walnut platform) on the 405L (ceder) ? I realize
> some changes to the 405GP network drivers is needed for the 405L, but does the
> basic kernel boot?

No, there are many platform and CPU differences between the two (Walnut
has PCI and PS/2, DCR's are at different addresses...)


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
