Message-ID: <3B7854DB.5020702@mvista.com>
Date: Mon, 13 Aug 2001 15:29:47 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CFI flash support for AMD chips
References: <3A494DE356A49A40B37442E1E0D9F3B5063419@ptah.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:

> Hello,
>
> I am trying to use the CFI flash support for AMD chips. I selected the
> CFI support in kernel configuration and defined the flash memory map on
> my board ( CFI Flash device in Physical memory map). I see that CFI is
> able to find the flash devices on my board correctly. Now, do I need to
> create a /dev/flash device in the dev directory? What Major, Minor
> numbers do I use? How do I actually use this driver???
>

check out the MTD home page. http://www.linux-mtd.infradead.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
