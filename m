Message-ID: <3967BFEE.1E024DE8@embeddededge.com>
Date: Sat, 08 Jul 2000 19:57:34 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> I found the source of the 4xx and 8xx troubles in the 2.4.xx kernel.

It wasn't really the source of the problem, but the functions are
still not correct here.  I converted the easy ones, the difficult one
is copy_tofrom_user with all of its potential exception cases.  I
converted for 16 and 32 bytes lines, but the 64 and 128 bytes lines
need some work.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
