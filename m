Date: Sun, 30 Sep 2001 13:13:08 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-ben0 doesn't see ide1
Message-Id: <20010930131308.156a8063.jpgarcia@execpc.com>
In-Reply-To: <20010930175148.29787@smtp.wanadoo.fr>
References: <20010930122211.2cf9b2f7.jpgarcia@execpc.com>
	<20010930175148.29787@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Sep 2001 19:51:48 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> BTW. Once that's fixed, does media bay works on lombard & wallstreet
> machines with my new kernel ? I rewrote the media bay driver but
> didn't yet have a chance to test it on anything but Pismo.
>
> Also, Joseph, did you notice similar problem with other OF resources
> ranges or is this specific to IDE ?

I think this is specific to IDE.  When it happened, I did a quick scan of the log for any other failures and found none.  But this was with a kernel from a linux-2.4.10-pre10-ben0 from 2001.09.21.  A recent linux-2.4.10-ben0-benh from 2001.09.29 seemed to work, but then the bottom fell out in the form of nothing could be found.  Binaries couldn't be run, etc.  (A few days before that, it couldn't mount root and panicked in boot.)

I'll see about testing one from today.  I still have a nasty problem of ADB locking up at random. Sometimes 2 minutes after boot, once almost 24 hours after boot.  Gotten it in the console and X, so I was thinking its either some corruption from the new video drivers (ATY-CT) or maybe some funky DMA race condition.  Would the semaphore proposed in adb.c help this?  PMU interrupts still get thru.  remote login -> procinfo show things still good, battery status still updated (maybe).

Building kernel...

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
