Date: Tue, 17 Oct 2000 10:05:39 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Matt Porter <mporter@mvista.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board
In-Reply-To: <20001016095706.B4206@beef.az.mvista.com>
Message-ID: <Pine.LNX.4.21.0010171002520.1915-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 16 Oct 2000, Matt Porter wrote:
> According to this dump, you are not running the latest linuxppc_2_5.
> The latest linuxppc_2_5 tree does not relocate memory BARs, only I/O
> BARs.  Not to mention the PReP relocation code doesn't properly update
> the memory resource limits.
>
> To get linuxppc_2_5:
>
> 	bk clone bk://bitkeeper.fsmlabs.com:5005 linuxppc_2_5

In fact I've done :
	bk clone bk://bitkeeper.fsmlabs.com:5000 linuxppc_2_5
                                              /|\

> If you really think you have the right tree, then email me privately
> your prep_pci.c and I'll let you know.

I'm downloading the right tree, I'll test it and let you know if
everything is right.

xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
