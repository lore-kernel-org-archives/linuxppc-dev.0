Message-ID: <3A12A26A.74AADEA6@agelectronics.co.uk>
Date: Wed, 15 Nov 2000 14:49:14 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dink32 downloads
References: <3A1291D5.71286AA7@agelectronics.co.uk> <20001115165231.C27345@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:
>
> Hi, Adrian!

> (You have to
> make sure the file has Unix-style newlines, though.)

Thanks. That was my problem all along. It turns out that
powerpc-eabi-objcopy -O srec puts DOS style newlines in the output.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
