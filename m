Subject: Re: Need IDE for embedded Linux project
From: Kenneth Johansson <ken@kieraypc01.tn.sw.ericsson.se>
To: brian.auld@adic.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <995FF289C9D69747A09E42992644595405B23618@penguin.adic.com>
References: <995FF289C9D69747A09E42992644595405B23618@penguin.adic.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 24 Jan 2003 18:39:29 +0100
Message-Id: <1043429969.4533.65.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-01-21 at 21:10, brian.auld@adic.com wrote:

> Option 4: Linux development server <--> PC-X server software
>           (hummingbird) on windows development hosts.

This is the one you want. But the windows machines would not be the
developent host but the x server. Since all the programs and files would
be on the one linux box that would be the development host.

You can test a setup like this with
http://www.cygwin.com/ + http://www.cygwin.com/xfree/ without spending
any money on software.

If you want to spend money I have previously used
http://www.ncd.com/products/software/pcxware/ and at least version 4
works quite good.

Also you want to configure this with XDM (XDMCP) this way it looks just
like everyone had their own linux computer.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Tellusborgsvägen  94              Fax: +46 8 404 72 72
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
