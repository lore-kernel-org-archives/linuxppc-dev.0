Date: Thu, 24 Jan 2002 09:43:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem to retrieve old LinuxPPC version
Message-ID: <20020124164359.GA1839@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C50349F.5070509@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C50349F.5070509@elsoft.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 24, 2002 at 05:21:51PM +0100, David M?ller (ELSOFT AG) wrote:

> If i try to go back to an old LinuxPPC kernel version
> (with bk export -rv2.4.10 /somewhere), i get a kernel tree, but some
> files seem to be missing (drivers/net/ppc405_enet.c for example),
> although i'm almost 100% sure this file was part of the
> linux-2.4.10_devel tree.

-rv2.x.x will get you kernel.org, as of 2.x.x.  You need to find the
changeset # of the merge of 2.x.x into the _devel tree.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
