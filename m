Date: Sun, 30 Sep 2001 14:39:46 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-ben0 doesn't see ide1
Message-Id: <20010930143946.24ad0a6b.jpgarcia@execpc.com>
In-Reply-To: <20010930191211.31520@smtp.wanadoo.fr>
References: <20010930131308.156a8063.jpgarcia@execpc.com>
	<20010930191211.31520@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Sep 2001 21:12:11 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Interesting... what is the exact symptom ? trackpad and keyboard
> not working any more ? I don't think the semaphore thing would
> change as it's quite specific to the ADB probe sequence.

Keyboard and trackpad no longer respond.  No logged error message.  System doesn't seem to notice anything happened.  If I try to sleep the system (close the lid), it sets up, almost gets there, and aborts.  Either something rejected the sleep request, or it did sleep but didn't really.  Not sure which.  rejection seems more plausable.  And if I shut down after an attempted sleep, the kernel panics at the last moment.  I had brute forced ability to ADB_RESET the bus, but that just oopsed the system like a sleep would.

> Do you get things back if you send ADB flush commands to the
> trackpad and/or keyboard ? (You can do that from userland
> via /dev/adb).

Ok.  I'll try that next time it happens.

Thanks.


--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
