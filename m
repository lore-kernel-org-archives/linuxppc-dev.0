In-Reply-To: <Pine.LNX.4.10.9912150919400.26215-100000@newhope.terraplex.com>
Date: Wed, 15 Dec 1999 17:44:42 +0100
To: Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PCNET32 driver
Message-Id: <19991215174442.007768@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 15, 1999, Stephen Edie <sedie@terraplex.com> wrote:

>When running in 100mbit mode, the PCNET32 driver reports the following
>error message:
>
>eth0:TX FIFO error! Status 02e3
>
>With this messages present, we have seen a number of problems from
>TCP connections being closed after a few bytes of transfer to very poor
>performance (1-mbit throughput) to not working at all.  Is there a quick
>way to fix this problem perhaps?  We would like to get some of our
>in-house CHRP machines running at the full 100mbit and we have some
>customers who require 100mbit throughput as well.

Which pcnet32 chip are you using ? There are some issues with
auto-negociation on some integreated-PHY models, and you may have to
adjust a few of the chip parameters. I used the pcnet32 driver with an
AMD 973 on an ARM platform and it worked just fine (after I fixed the
cache coherency issues but those won't happen on PPC).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
