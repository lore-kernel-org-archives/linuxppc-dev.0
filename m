MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15214.30891.857319.377917@mediaone.net>
Date: Mon, 6 Aug 2001 06:59:55 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: Olaf Hering <olh@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <20010806100644.A6859@suse.de>
References: <20010805200639.A14938@suse.de>
	<Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>
	<20010806100644.A6859@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:
 > This isnt the correct fix, only a workaround to avoid a kernel arg ;)

I tried all the kernel video args that made sense to me and all the
ones that were suggested to me by others.  None of them worked.  The
second version of the patch works.


 > The correct fix is either "video=1280x1024-8@60" as kernel arg
 > (that may work)

This is *not* one of the ones I tried.  At this point all the kernels
I have on hand have already been hacked with the workaround patch, so
I can't test this on a "clean" kernel until I have time to build one.
Next weekend, maybe.  I seem to be the one and only tester for this
issue, so I'll try to do it sooner if I can...

Is '-8' the depth?  I.e., should I replace this with '-24' if I want
24-bit color?



--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
