Message-ID: <399C3CD7.51CCB044@embeddededge.com>
Date: Thu, 17 Aug 2000 15:28:23 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: dan@netx4.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with string.S
References: <399A4220.23A3B0F5@research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:

> .....  I've been doing some 2.2.13
> kernel profiling on the 860, and __copy_tofrom_user is coming up as a
> hotspot.

In what kind of test?

> I tried dropping in the new improved version from
> linux-2.4.0-test7-pre4, and none of the 8xx mods are in there: it'l only
> work for 32 byte cache lines.

Hmmm....I check it into the FSM BK tree a long time ago.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
