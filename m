Message-ID: <38CD39B5.A91B1B92@erols.com>
Date: Mon, 13 Mar 2000 13:55:50 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "James B. Parker" <pajama1@mindspring.com>
CC: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86 4.0
References: <B4F29FFF.1522%pajama1@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"James B. Parker" wrote:

> _first_
> It asks for a file call libqt.0.2 or something like that (I know the libqt
> part is correct).  Although this problem may have cleared up after I built
> it a second time, I tried to reinstall KDE from a rpm (thinking this may
> solve the second issue) and a message was displayed requesting the above
> mentioned file.

I would assume that libqt (probably libqt.so.2 or something like that) is part
of the qt developement package..

According to rpmfind.net, libqt.so.2 is provided by the qt package, you
probably also want the qt-devel package.

> _second_
> When I try to start the server (xinit, startx, X) there is a fatal error:
> no screens

What is the fatal error?  I don't think this would be related to the libqt, as
qt is a kde package for graphics, and shouldn't be related to the X server
working/not working (AFAIK).

What is the fatal error?

HTH
--Nelson Abramson

--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
