Date: Thu, 11 Oct 01 18:53:12 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110120153.AA28702@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Okay, does the following look right/work for everyone?
>
> [...]
>
> -			initrd_end = data[0] + rec->size;
> +			initrd_end = data[0] + data[1];

This should work for me.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
