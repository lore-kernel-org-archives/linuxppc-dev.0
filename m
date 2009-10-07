Return-Path: <davem@davemloft.net>
Date: Wed, 07 Oct 2009 14:09:38 -0700 (PDT)
Message-Id: <20091007.140938.255120957.davem@davemloft.net>
To: crn@netunix.com
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
References: <20091007135243.GC21646@anhedonia> <4ACCEC67.9070106@firmworks.com>
	<Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sammy@sammy.net, sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	julian.calaby@gmail.com, wmb@firmworks.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chris Newport <crn@netunix.com>
Date: Wed, 7 Oct 2009 21:54:34 +0100 (BST)

> Sun4c has also been broken for a long time and sun4d has never worked
> properly. Is it time to also prune these ?.
> That would leave only Sun4m in the 32bit kernel, which still works and
> has plenty of ongoing user interest.

Chris don't over-exaggerate the state.

The truth is that the whole sparc32 port is in a state of mild
disrepair, and many of the issues apply to all the port rather than
just one family of systems.  I think someone suitably motivated
could get most of the bugs sorted out.

There is no reason to drop support for SS1 machines, we already fully
build the software device tree and use all of the generic OF
infrastructure in the Linux kernel on those systems.  It is not a road
block at all for the OF genericization work, if that's what you read
into wmb's email.
