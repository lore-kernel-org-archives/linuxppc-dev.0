Date: Mon, 13 Mar 2000 19:59:23 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "James B. Parker" <pajama1@mindspring.com>
cc: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86 4.0
In-Reply-To: <B4F29FFF.1522%pajama1@mindspring.com>
Message-ID: <Pine.LNX.4.10.10003131953540.6906-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I downloaded the source code to Xfree86 4.0 and built/installed it.
> Everything seemed to go well.  Now my Xserver is unable to start.

You'll need to create a new XF86Config (XFree86 -configure should, in
theory, do that).
Depending on your kind of video hardware, XFree 4.0 will just not work at
this time. I spent the last few days debugging the X server on my Lombard
and almost trashed my installation in the process. It seems with the new
XFree release, the X server on PPC finally became equally unstable as the
Intel one :-)

I'll sit back and wait for specific patches to try (on top of cleaning up
the mess that my latest test left, backing up my system, and creating an
emergency boot zip).

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
