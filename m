Message-ID: <3E663C1D.7060104@ecubics.com>
Date: Wed, 05 Mar 2003 11:04:13 -0700
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel boot on mpc8245
References: <3E654405.6020904@ecubics.com> <3E662D79.9030904@pp.iij4u.or.jp> <3E663145.7060605@mvista.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer wrote:
> My recommendation for a first step is to look at your printk data. You
> didn't miss a flag, you're simply crapping out before the console is set
> up to dump out the printk data.
>
> Go into the System.map file associated with the kernel your running,
> search for 'log_buf', subtract 0xc0000000 to get the physical addr of
> 'log_buf', hook up a BDI or something similar (and hopefully, your board
> has an appropriate connector), and dump the [printk] data at that address.

I have the connector, but not a BDI2000 :(

And the log_buf ends with:

0019f544: 20617263 682c2062 65666f72 65206669     arch, before fi
0019f554: 6e645f62 72696467 6573200a 3c363e45    nd_bridges .<6>E
0019f564: 63756275 65726f20 50383234 35205369    cubuero P8245 Si
0019f574: 6e676c65 20426f61 72642043 6f6d7075    ngle Board Compu
0019f584: 7465720a 3c363e50 6f727420 62792065    ter.<6>Port by e
0019f594: 6d750a3c 343e4f6e 206e6f64 65203020    mu.<4>On node 0
0019f5a4: 746f7461 6c706167 65733a20 33323736    totalpages: 3276
0019f5b4: 380a3c34 3e7a6f6e 65283029 3a203332    8.<4>zone(0): 32
0019f5c4: 37363820 70616765 732e0a3c 343e7a6f    768 pages..<4>zo
0019f5d4: 6e652831 293a2030 20706167 65732e0a    ne(1): 0 pages..
0019f5e4: 3c343e7a 6f6e6528 32293a20 30207061    <4>zone(2): 0 pa
0019f5f4: 6765732e 0a3c343e 4b65726e 656c2063    ges..<4>Kernel c
0019f604: 6f6d6d61 6e64206c 696e653a 20636f6e    ommand line: con
0019f614: 736f6c65 3d747479 53302c31 31353230    sole=ttyS0,11520
0019f624: 3020636f 6e736f6c 653d7474 79302072    0 console=tty0 r
0019f634: 6f6f743d 2f646576 2f72616d 2072770a    oot=/dev/ram rw.
0019f644: 00000000 00000000 00000000 00000000    ................

Cheers & thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
