Date: Mon, 28 Jun 2004 06:00:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
In-Reply-To: <20040628035850.GA30977@gate.ebshome.net>
Message-ID: <Pine.LNX.4.60.0406280557420.3259@localhost.localdomain>
References: <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain>
 <20040628035850.GA30977@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(as wolfgang also responded to this, i'll save some feedback for his
post.)

On Sun, 27 Jun 2004, Eugene Surovegin wrote:

> Yes, this is possible and actually quite trivial.
>
> Partition your flash the way you want, e.g. reserve part of the
> flash chip for root fs, place filesystem into it and mount
> corresponding mtdblock device during boot, e.g. use something like
> "root=/dev/mtdblock1" if you have several fs compiled into your
> kernel you can use additional command line parameter
> "rootfstype=<your_root_fs>" to prevent kernel trying all registered
> fs while mounting root.

yes, i found out that it was, in fact, kind of embarrassingly easy. i
just followed a sample partition definition in rpxlite.c and, lo and
behold, it just worked.  i'm not used to having things just work. :-)

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
