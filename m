Message-ID: <3BD60FF5.24C4B841@mandrakesoft.com>
Date: Tue, 23 Oct 2001 20:48:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: any easy way to force 10/100 nics to 10?
References: <20011023211459.NUPA19597.tomts17-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:
>
> Hi,
>
> My new dsl router seems to hate 100 connections from my 10/100 nics.
>
> Is there an easy way to force 10mb speed (a /proc setting?)?

The standard way, in this order, is (a) via ethtool, (b) via mii-tool,
or (c) using a command line option at kernel boot time.

--
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
