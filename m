Date: Wed, 8 Jan 2003 18:32:15 +0100
From: Boris Bezlaj <boris@bandit.kista.gajba.net>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
Message-ID: <20030108173215.GA1002@bandit.kista.gajba.net>
References: <3E1BECD2.9060909@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E1BECD2.9060909@intracom.gr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 08, 2003 at 11:18:10AM +0200, Pantelis Antoniou wrote:

> BTW, are there any gotchas, or anything
> I should pay attention moving
> from 2.4 -> 2.5?

AFAIK, you need the new module-init-tools for loading/unloading modules.

I see there is a little patch for swim3 driver. Do you have any problems
with swim3 driver in 2.4 kernel when writing to floppy? What is the status
in v2.5?

--
With best regards,
			Boris B.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
