Date: Mon, 13 Mar 2000 13:39:11 -0500
Subject: Xfree86 4.0
From: "James B. Parker" <pajama1@mindspring.com>
To: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B4F29FFF.1522%pajama1@mindspring.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I downloaded the source code to Xfree86 4.0 and built/installed it.
Everything seemed to go well.  Now my Xserver is unable to start.

Two observations:

_first_
It asks for a file call libqt.0.2 or something like that (I know the libqt
part is correct).  Although this problem may have cleared up after I built
it a second time, I tried to reinstall KDE from a rpm (thinking this may
solve the second issue) and a message was displayed requesting the above
mentioned file.

_second_
When I try to start the server (xinit, startx, X) there is a fatal error:
no screens

So what is libqt# and how do I remedy this issue and what is the story with
the screens?  I am unfamiliar with screens and the need for them in Xserver.

Anyway, any info is appreciated!
James B. Parker

Mac G3 266mhz beige rev. 2


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
