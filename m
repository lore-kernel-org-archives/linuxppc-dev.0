Date: Fri, 31 Oct 2003 11:25:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Prakash Kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Max RAM for Linux only 1GB?
Message-ID: <20031031112500.A32632@home.com>
References: <20031031165821.17006.qmail@web41215.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031031165821.17006.qmail@web41215.mail.yahoo.com>; from pkanthi@yahoo.com on Fri, Oct 31, 2003 at 08:58:21AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 31, 2003 at 08:58:21AM -0800, Prakash Kanthi wrote:
>
> Folks,
>
> I have over 1GB DIMM RAM on my board running PPC 405.
> How can i ioremap that to my OS? As Linux virtual
> space starts at 0xC0000000, we have only 1GB more for
> all virtual space mappings.
>
> Even if i move 0xC0000000 to 0x80000000, what will
> happen to TLB settings? Any problem there to map 1GB
> additional RAM?
>
> Any idea as to how i can do this?

Use CONFIG_HIGHMEM or move KERNELBASE like you suggest.

You don't ioremap your system memory (well, under normal
conditions).

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
