Date: Thu, 3 Apr 2003 13:19:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [TRIVIAL PATCH] linuxppc_2_4_devel: boot/common/misc-simple.c
Message-ID: <20030403201916.GB4284@ip68-0-152-218.tc.ph.cox.net>
References: <20030403200852.GA3137@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030403200852.GA3137@rover.farnsworth.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 03, 2003 at 01:08:52PM -0700, Dale Farnsworth wrote:

> Declare decompress_kernel to avoid compiler warnings about type mismatches.

That's a "d'oh", and fixed in a different manner that will be pulled in
for 2.4.21-pre7, once tagged.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
