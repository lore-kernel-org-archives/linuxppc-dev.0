Message-ID: <38C7C46A.D995D187@email.sps.mot.com>
Date: Thu, 09 Mar 2000 09:34:02 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB driver for MPC850/823
References: <4.2.2.20000308153704.00a601f0@mail.kerbango.com> <38C7368A.7B28E61E@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Dan Malek wrote:
>
> Just make sure kmalloc() gives you something that is properly
> aligned, as some CPM functions have rather large alignment boundaries.
> When allocated in this way, you have to chase down the pte's and modify
> the cache attributes yourself if desired.

The most famous case of this is the IDMA buffer descriptors.  Unlike
everything elses buffer descriptors, the IDMA buffer descriptors must be
16 byte aligned, not 8.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
