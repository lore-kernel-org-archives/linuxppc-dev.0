Message-ID: <3987B66D.B28457A9@lightning.ch>
Date: Wed, 02 Aug 2000 07:49:33 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: question of 'SIZEOF_HEADERS' !!!!!!!!!!!!!!!
References: <015401bffbae$1aa27940$bf0102c8@sc.mcel.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rolf Liu wrote:
>
> Hi, all
> I am linking the linux ppc kernel .
> I found a symblo named 'SIZEOF_HEADERS' in the link script file
> 'vmlinux.lds'.
> I wonder where the symbol come from.

Found in ld's info pages, section arithmetic functions :

`SIZEOF_HEADERS'
`sizeof_headers'
     Return the size in bytes of the output file's headers.  You can
     use this number as the start address of the first section, if you
     choose, to facilitate paging.


				Daniel Marmier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
