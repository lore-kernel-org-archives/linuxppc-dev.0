Message-ID: <3992C0ED.E66C42FF@embeddededge.com>
Date: Thu, 10 Aug 2000 10:49:17 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Wojciech Kromer <krom@dgt-lab.com.pl>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: too few RAM?
References: <00Jun4.144038est.115228@border.alcanet.com.au>
		 <393BBE5D.49B17E9C@embeddededge.com> <00Jun6.135659est.115272@border.alcanet.com.au> <39929A9C.C17E22D7@dgt-lab.com.pl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wojciech Kromer wrote:
>
> i'm trying to run  mpc8xx-2.2.13 (with all patches I found)
>  - with 8xxrom (0.3.0)
>  - on MPC8XXFADS
>     .MPC823e
>     .4MB RAM
>     .2MB FLASH

Yes, sorry, this is too little RAM.  A long time ago in a land
far, far away (before initrd support), you could boot in less than 8
Mbytes.  Not any more.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
