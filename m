Message-ID: <3A804C24.4BA29BB1@mvista.com>
Date: Tue, 06 Feb 2001 14:10:28 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on a 823FADS
References: <3A7F4C08.21F4AC7E@intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Bruno R. Barreyra" wrote:

> How am I supposed to build the kernel? It seems the FADS port has long
> been abandoned. I'm trying to revive it,

You can find the FADS LSP on the MontaVista server in /pub/Area51.
It is based on a 2.4.0-test2 kernel and works fine on the 860.  All
you need to do is update the SCC Ethernet configuration and you should
be all set.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
