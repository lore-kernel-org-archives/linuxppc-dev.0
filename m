Date: Tue, 27 May 2003 09:58:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jean-Denis Boyer <jdboyer@m5t.com>,
	Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PATCH: arch/ppc/8xx_io_fec.c
Message-ID: <20030527165824.GG3453@ip68-0-152-218.tc.ph.cox.net>
References: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 27, 2003 at 10:38:49AM -0400, Jean-Denis Boyer wrote:

> I discovered an old bug in the Fast Ethernet driver of the 860T.
> In function fec_restart, the FEC is reset with no concern
> to pending MDIO requests.

Dan, do you see any problems with this?  If not, I'm going to put this
into a tree to get it out and into 2.4.22-pre.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
