Date: Tue, 29 Jun 2004 16:15:38 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing" 
In-Reply-To: <Pine.LNX.4.60.0406290859430.24373@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0406291606500.5355@mag.sysgo.com>
References: <20040629125710.B6B28C109F@atlas.denx.de>
 <Pine.LNX.4.60.0406290859430.24373@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 29 Jun 2004, Robert P. J. Day wrote:

> excellent, this just gets better and better.  however, will partition
> definitions on the command line override those in rpxlite.c?  i notice
> that the generic rpxlite.c that comes from the bk tree has a default
> partition definition of fe000000/800000.  should that be removed
> first?  or will it be ignored?  it's not clear from the comments in
> the source.

I don't think your version of rpxlite.c supports command line
partitioning at all. The official one doesn't. You should see the
existing mapping drivers such as physmap.c to learn how to add this,
it is not difficult.

The implementation should always give precedence to the command line
defininition.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
