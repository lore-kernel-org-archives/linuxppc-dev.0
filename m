Date: Wed, 31 Mar 2004 20:18:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Whitney <johnw@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331181852.GA20127@lst.de>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 10:44:25AM -0500, John Whitney wrote:
> 1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
> phys_to_virt.  With the use of fully virtual addresses for

These are all obsolete interface and you're not supposed to use them
for new plattforms or drivers at all.

>
> 2. I'd like to add 64-bit __raw_readll and __raw_writell routines to
> io.h, done using floating-point registers.  Currently, modules such as
> MTD (when writing to 64-bit buses) perform two 32-bit, non-atomic
> writes, which can cause problems.  Using a floating-point register to
> guarantee a 64-bit write is ugly, but it works.  Code for these inlined
> routines is as follows:

Standard-naming for those are readq/writeq afaik


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
