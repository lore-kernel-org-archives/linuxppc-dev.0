Message-ID: <3896C7E6.D6B236B3@ctam.com.au>
Date: Tue, 01 Feb 2000 22:47:51 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: szg98@mail.zhongxing.com,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <48256878.00018A59.00@mail.zhongxing.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


szg98@mail.zhongxing.com wrote:

> Hi,
>      I don't think you have an incorrect UPM setting. When the kernel was
> being decompressed , decompress_kernel() has use ram as stack.

Yes but the kernel isn't running yet.  It runs after it is decompressed.  When
it starts running it normally enables the caches (I commented out this code)
and sets up the MMU.  Maybe the MMU requires the caches ?
]
Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
