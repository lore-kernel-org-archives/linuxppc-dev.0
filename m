In-Reply-To: <1089977681.27006.90.camel@kubu.opensource.se>
References: <s0f7edc2.025@EMAIL> <1089977681.27006.90.camel@kubu.opensource.se>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2E803D2B-D72C-11D8-B668-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Rupesh S <rupeshs@myw.ltindia.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 09:29:36 -0400
To: Magnus Damm <damm@opensource.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 16, 2004, at 7:34 AM, Magnus Damm wrote:

> kmalloc allocates from the kernel memory pool, ie your sdram.
> you usually have several megabytes of sdram.
> hostalloc allocates memory from the internal dpram area in the mpc8xx

No, it does not.  hostalloc allocates from the processor sdram, it
is not cached.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
