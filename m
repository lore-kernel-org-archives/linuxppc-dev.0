To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb.c missing from rync'd benh sources...
References: <20010726200759.A19851@garmonbozia.productivitynet.com>
	<20010726200901.C8790@localhost.localdomain>
	<87elr3xjov.fsf@cgsoftware.com>
	<20010726212643.31b93eeb.jpgarcia@execpc.com>
From: Daniel Berlin <dan@cgsoftware.com>
Date: Fri, 27 Jul 2001 01:26:43 -0400
In-Reply-To: <20010726212643.31b93eeb.jpgarcia@execpc.com> ("Joseph P. Garcia"'s message of "Thu, 26 Jul 2001 21:26:43 -0500")
Message-ID: <87ae1rx7qk.fsf@cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Joseph P. Garcia" <jpgarcia@execpc.com> writes:

> On Thu, 26 Jul 2001 21:08:32 -0400
> Daniel Berlin <dan@cgsoftware.com> wrote:
>> You just aren't using the --delete flag, so it never deleted the file.
>
> Confirmed.  Just ran a sync.
>
> ...
> deleting toto
> deleting fs/cramfs/cramfs.h
> deleting drivers/video/aty128fb.c
> deleting drivers/ieee1394/guid.h
> deleting drivers/ieee1394/guid.c
> deleting drivers/ieee1394/aic5800.h
> deleting drivers/ieee1394/aic5800.c
> ...
>
> And rsync will only delete files if run with the --delete flag.


Right. Mirrors with extra space will keep older, deleted, versions of files
around (remember, rsync is a mirroring tool), while those with less
space will just want an exact mirror (or whatever). Hence the
--max-delete flag, and whatnot.




>
> --
> Joseph P. Garcia
> http://www.lycestra.com/
>

--
"I didn't get a toy train like the other kids.  I got a toy
subway instead.  You couldn't see anything, but every now and
then you'd hear this rumbling noise go by.
"-Steven Wright

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
