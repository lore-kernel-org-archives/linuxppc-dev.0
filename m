From: Benjamin Herrenschmidt <bh40@calva.net>
To: Chris Backas <cbackas@bigfoot.com>, <linuxppc-dev@lists.linuxppc.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0test13 + Dual G4
Date: Tue, 26 Dec 2000 19:29:40 +0100
Message-Id: <19341120120124.27878@192.168.1.2>
In-Reply-To: <E149b3B-0007Wq-00@smtp01.mrf.mail.rcn.net>
References: <E149b3B-0007Wq-00@smtp01.mrf.mail.rcn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>As per the advice from various list members (thanks all who responded!)
>regarding my random-coredumps under 2.2.18 in SMP mode, I've now upgraded
>to kernel 2.4.0
>Test 13.  I was unable to build it myself (unresolved references in the
>link step that I couldn't figure out) I grabbed a pre-built SMP kernel from
>ftp.linuxppc.org/users/kfukui.
>
>The kernel worked fairly well, (and was REALLY REALLY FAST!) but
>something went wrong with XFree86 (4.0.1) and my screen went blank and
>wouldn't return.  Sooo... I
>upgraded to Xfree86 4.0.2 from the same source.  Once I fixed a bad
>symlink that the RPM created (X linked to XPMac instead of XFree86) XFree
>worked again.
>
>SO, getting to the point of the mail - with the newest kernel and newest
>XFree, my mysterious crashes still exist.  Mozilla Mail is the biggest
>culprit, nearly every time I open
>it it dies.  No core, it just disappears.  This does not happen on a Uni-
>processor kernel.

Two things come to my mind:

 - Paul fixed another SMP issues very recently. Make sure you get the
linuxppc_2_3 (or eventually _2_5) tree from hq.fsmlabs.com to get the fix

 - There are some issues with XFree 4. vs. Linux SMP (generic issues on
x86 too) that have been discussed several times on XFree list. XFree
people tend to say it's a kernel problem, while nobody (AFAIK) on the
kernel camp have made any comment.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
