Date: Thu, 26 Jul 2001 21:26:43 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb.c missing from rync'd benh sources...
Message-Id: <20010726212643.31b93eeb.jpgarcia@execpc.com>
In-Reply-To: <87elr3xjov.fsf@cgsoftware.com>
References: <20010726200759.A19851@garmonbozia.productivitynet.com>
	<20010726200901.C8790@localhost.localdomain>
	<87elr3xjov.fsf@cgsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 26 Jul 2001 21:08:32 -0400
Daniel Berlin <dan@cgsoftware.com> wrote:
> You just aren't using the --delete flag, so it never deleted the file.

Confirmed.  Just ran a sync.

...
deleting toto
deleting fs/cramfs/cramfs.h
deleting drivers/video/aty128fb.c
deleting drivers/ieee1394/guid.h
deleting drivers/ieee1394/guid.c
deleting drivers/ieee1394/aic5800.h
deleting drivers/ieee1394/aic5800.c
...

And rsync will only delete files if run with the --delete flag.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
