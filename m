Message-ID: <007401c18912$d0b58c20$1a11efcb@industrialDiv.hanasys.co.kr>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <3C214290.D6D1B53A@carts.com>
Subject: Re: allocating non-cacheable memory
Date: Thu, 20 Dec 2001 13:57:23 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
Setting up a BAT by some asembler code is good.
Or you can use io_block_mapping.
For example
io_block_mapping(0x78000000, 0x78000000, 0x08000000, _PAGE_IO);
It maps phisical address 0x78000000 ~ 0x7FFFFFFF to effective address  0x78000000 ~ 0x7FFFFFFF, No cache.
- Sangmoon Kim -

----- Original Message -----
From: "Kevin Fry" <kevin@carts.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, December 20, 2001 10:44 AM
Subject: allocating non-cacheable memory


>
> What is the best way to allocate some non-cacheable memory for I/O use?
> Right now we are going to setup a BAT table with a non-cacheable memory
> region and use that for all I/O, but does linux have a nice neat
> function to grab a page and set it up non-cacheable for us?
> I was reading in the archives that the #define PAGE_NOCACHE doesn't
> work.
>
> thanks!
>
> Kevin
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
