Message-ID: <3E70A40D.6090408@embeddededge.com>
Date: Thu, 13 Mar 2003 10:30:21 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: accessing immap_t * variable in mpc8260
References: <3E70A2C3.8090305@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan wrote:

> I am confused at this point, that how can kernel code access a physical
> address as if it were virtual address ? how does the page frame -> page
> conversion (and vice versa) happens on this front?

There are some kernel address spaces that are mapped 1:1 virtual
to physical, that is, the virtual address matches the physical one.
Sometimes it is for convenience, sometimes it just works that way.
Sometimes it is because we need to access a space with the MMU
disabled and it is easier this way.

The IMMR is one such space that is mapped this way.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
