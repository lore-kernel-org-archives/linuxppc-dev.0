Message-Id: <200008242356.AAA30017@hyperion.valhalla.net>
Date: Fri, 25 Aug 2000 00:56:49 +0100
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I couldn't find the awacs stuff in my last darwin xnu download,
> has it moved out of the xnu projects, or did I just get lost?

They moved the stuff around a while back.

All the audio stuff is now under a module called "IO" at the top level of
the darwin cvs tree.

The audio driver directories under xnu are currently empty (although someone
on the darwin-dev posted a question a couple of days back about when they
would be filled in).

HTH
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
