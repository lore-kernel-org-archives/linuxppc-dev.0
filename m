Message-ID: <3DE4FCC9.E62EF5B1@synergymicro.com>
Date: Wed, 27 Nov 2002 09:11:37 -0800
From: Dave Wilhardt <wilhardt@synergymicro.com>
Reply-To: wilhardt@synergymicro.com
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Gabriel Paubert <paubert@iram.es>, wilhardt@synergymicro.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455 and lwarx
References: <3DE3EF0B.F3204162@synergymicro.com> <3DE4C207.8020500@iram.es> <3DE4DAE1.9060602@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
> Why do you want to use these instructions on a data space that isn't
> cached?  Further, why are you running this class of processor with
> uncached memory?
>

I have a "shared memory" region that is used between VME boards in
a chassis.  The "master pool" is located on the system controller in DRAM.
In order to maintain coherency between the boards, I have marked the region
as non cached.  This was fine for non-MPC745x boards.  Time for a redesign...

- Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
