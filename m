Reply-To: <yooth@ipone.co.kr>
From: "Yoo. Jonghoon" <yooth@ipone.co.kr>
To: "Dan Malek" <dan@mvista.com>, "Matthew Locke" <mlocke@mvista.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Starting usb in RPXlite(mpx850) board
Date: Mon, 25 Jun 2001 09:08:59 +0900
Message-ID: <NFBBLHGHILCOPCKBODHAOEAFCBAA.yooth@ipone.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3B34CA3C.85F61D60@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working on RPXlite(mpc850) board and need USB to work as soon as
possible. What is needed to do so? CPM microcode is the only issue?
Just a little hint would be enough to plan my work..

Thanks in advance.

> > uh, I believe so.  If I remember correctly, USB is only supported on the
> > 823 rpxlite DW.
>
> ...and, if I recall correctly, the CPM microcode patch to enable this
> was written for the Rev. B 823(e).  I know it won't work on a Rev. A 823
> part, and we never pursued making it work on an 850 due to lack of a
> board
> with USB.  It would also require the Rev. B 850 if there was any hope
> of it working there.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
