From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.10-ben0 doesn't see ide1
Date: Sun, 30 Sep 2001 21:12:11 +0200
Message-Id: <20010930191211.31520@smtp.wanadoo.fr>
In-Reply-To: <20010930131308.156a8063.jpgarcia@execpc.com>
References: <20010930131308.156a8063.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'll see about testing one from today.  I still have a nasty problem of
>ADB locking up at random. Sometimes 2 minutes after boot, once almost 24
>hours after boot.  Gotten it in the console and X, so I was thinking its
>either some corruption from the new video drivers (ATY-CT) or maybe some
>funky DMA race condition.  Would the semaphore proposed in adb.c help
>this?  PMU interrupts still get thru.  remote login -> procinfo show
>things still good, battery status still updated (maybe).

Interesting... what is the exact symptom ? trackpad and keyboard
not working any more ? I don't think the semaphore thing would
change as it's quite specific to the ADB probe sequence.

Do you get things back if you send ADB flush commands to the
trackpad and/or keyboard ? (You can do that from userland
via /dev/adb).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
