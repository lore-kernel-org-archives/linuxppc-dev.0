From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200301121924.h0CJOr726067@hofr.at>
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't access tt
 y; job control turned off
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC06037@SNCMAIL> from James Don
 at "Jan 12, 2003 02:19:04 pm"
To: James Don <JDon@spacebridge.com>
Date: Sun, 12 Jan 2003 20:24:53 +0100 (CET)
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi,
>
> I am looking at a ramdisk image ... I am curious if anyone could give me a
> tip as to why when my bash starts I have no "job contol" (ctrl-z etc) ... se
> below ...
>
> BusyBox v0.60.5 (2003.01.09-00:51+0000) Built-in shell (ash)

busybox builtin shell has no job control by default - for ash you have to
enable it at compile time.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
