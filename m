Subject: Re: PowerMac vs. Intel for PowerPC Development Host
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: brian.auld@adic.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
References: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 19 Feb 2003 23:29:34 +0100
Message-Id: <1045693774.30141.74.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-02-19 at 22:52, brian.auld@adic.com wrote:

> Out of all the feedback I received, only one person suggested developing on
> a PowerMac based Linux box, thus eliminating the need for cross-compiling. I
> have become more interested in this option as some people in our company
> have noted that cross-compiling embedded linux presented problems on past
> projects when it came to building certain 3rd party applications.

Compiling on a powerpc platform dose not automatically make things just
work you may have to build a cross compiler anyway depending on what
bugs in the target you have to work around.

Some programs is simpler to build native for sure but on the few times I
resorted to that I could build on the development card. It's nice to
have more than one platform for other reasons like when things do not
work you have something to compare against.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  94              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
