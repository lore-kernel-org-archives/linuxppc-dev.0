Message-ID: <38F49C00.F05038B@mondonet.net>
Date: Wed, 12 Apr 2000 14:53:36 -0100
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: "Michael A. Peters" <moonglue@141.com>
CC: gcc-bugs@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: gcc-2.95.2-ppclinux-internal bug
References: <v04220800b519ef5416a8@[192.168.0.2]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael A. Peters" wrote:
>
> My profound apologies if this is a well known bug.
>
> While compiling gstep-0.6.5 it didn't make it all the way, compaining
> of an internal compiler error.
>
> Platform is linux (2.2.14) on a PowerPC (750/G3)
> gcc 2.95.2 compiled with languages c,c++,objc with options
> enable-threads, enable-cpp, enable-shared. It was compiled by me from
> stock gnu source and works splendidly on other things.
>
> The product being compiled was gstep-0.6.5 (GNUstep)

You should disable optimization when compiling this
product. It's in the documentation btw.

Mario Scarpa.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
