Date: Sun, 23 May 1999 16:27:48 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: laures@esiea.fr
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Good news for the Initio Miles owners
In-Reply-To: <199905232019.PAA10710@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.05.9905231625280.650-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 23 May 1999 laures@esiea.fr wrote:

> I can partition, format, copy/erase stuff -> no problem so far, although
> I'll do some deeper tests (any advice on extensive tests, benchmarking
> etc ?)

10 large copy/erase/repeats at a time for an hour or so,  then force an
fsck?

> My advice is to keep it as a module, and then do as root "insmod
> /lib/module/2.2.6/scsi/initio.o".
> If not, the order of the HDs will change (sda, sdb etc...) and the
> system may not boot at all

That's just due to the search order.  For some odd reason, we go by
what's attached to what (inito before, mesh, before nc53c94(?)).  But if
the driver becomes useable and stable, just change your /etc/fstab to
reflect the new order. :)
 
---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
