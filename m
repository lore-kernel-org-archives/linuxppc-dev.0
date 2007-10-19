Return-Path: <Martin.Leisner@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: embedded a default dtb in the kernel (was merge dtc)
Date: Fri, 19 Oct 2007 14:30:28 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "linuxppc-dev" <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there a way to embed a default dtb into the kernel?
When I build a kernel, I want to embed a dtb into it --
so I don't have to deal with the headaches of finding the
right file to match the right board (its always easier to
deal with 1 file than 2).

If there is, it makes sense to put dtc into the tree.
If there's not, there should be a way to embed dtb's; and put
dtc and dts's into the tree.
If there can't be (I haven't examined this but relaying my
experiences), then it should be in a separate repository
(but the DTS and DTC should be in one place).
It was a little difficult to cobble together a working=20
system the first time.

Also, mkimage SHOULD definitely go in the tree.  Its necessary
to build, hence should be in the tree...

There are cases where one kernel can support multiple boards/DTBs.
I guess boot flags can control whether to use an embedded DTB or
one passed from uboot...

marty
