Date: Wed, 5 Mar 2003 10:07:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Wolfgang Denk <wd@denx.de>, Paul Mackerras <paulus@samba.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030305170758.GA19303@ip68-0-152-218.tc.ph.cox.net>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com> <20030305010318.6A4D3C6E0C@atlas.denx.de> <20030305022134.GR24171@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030305022134.GR24171@kalmia.hozed.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 08:21:35PM -0600, Troy Benjegerdes wrote:

> Dale, instead of changing head.s, can you use your own relocate.s for
> your wrapper? Don't you have to mess around with holding the 2nd cpu in
> the wrapper?

Ack, no.  I'd rather see if #ifdef CONFIG_SMP first, but on the whole I
think there's a better solution for everyone.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
