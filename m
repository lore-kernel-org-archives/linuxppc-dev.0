Message-ID: <38F1B9CB.D23AA3F3@uow.edu.au>
Date: Mon, 10 Apr 2000 21:23:55 +1000
From: Andrew Morton <andrewm@uow.edu.au>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-dev@lists.linuxppc.org,
        Linux kernel mailing list <linux-kernel@vger.rutgers.edu>
Subject: Re: PATCH: requesting feedback on dead function optimisation
References: <20000410090550.8B25E5057F@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:
>
> Fellow kernel hackers,
>
> For the last couple of weeks I've been looking at how to get gcc/ld to
> automatically optimise unused functions and data out of the kernel.

Graham, do you have any numbers on what this does to the overall build
size?

--
-akpm-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
