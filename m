Date: Fri, 24 Aug 2001 11:23:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Elan Feingold <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CONFIG_SERIAL_CONSOLE question
Message-ID: <20010824112330.C23383@cpe-24-221-152-185.az.sprintbbd.net>
References: <NDBBLJKOJGKDOFBHNPGEKEIHCEAA.elan@nxnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBLJKOJGKDOFBHNPGEKEIHCEAA.elan@nxnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 24, 2001 at 12:27:01PM -0500, Elan Feingold wrote:

> I'm using Linux 2.4.4-2001-07-23, targetting a custom 860T board with FEC
> based on BSEIP board.  It comes up fine, but when it goes to mount the NFS
> root and start init, I invariably get a:
>
> "Oops: kernel access of bad area, sig: 11"

Do you get anything else?  A BUG()?  If so, try turning on CONFIG_CPU6 or so.
If it's already on, forget I said anything... :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
