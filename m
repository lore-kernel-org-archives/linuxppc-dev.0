Date: Fri, 14 Mar 2003 10:25:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kgdb and console output
Message-ID: <20030314172536.GF6421@ip68-0-152-218.tc.ph.cox.net>
References: <1047642589.367.19.camel@muse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1047642589.367.19.camel@muse>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 11:49:50AM +0000, Ibon Gotxi Garcia wrote:

[snip]
> INIT: INIT: NIT: IT: T: : version 2.78 bootingersion 2.78 bootingrsion
> 2.78 bootingsion 2.78 bootingon 2.78 booting
>
> and so on.
>
> a.- Is that a gdb problem?
> b.- Is it related with using the same serial port for both output and
> debugging?
> c.- Maybe i should change the tools i use in the root filesystem (aka
> /bin/echo ...)?

It's related to the 'console' support inside of the serial driver / kgdb
stub.  The best way, IMHO, around this is to use the 'kgdb_demux'
script.  I don't have the URL handy, but google knows.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
