Return-Path: <oftedal@gmail.com>
Date: Thu, 8 Oct 2009 15:24:43 +0200 (CEST)
From: Kjetil Oftedal <oftedal@gmail.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
In-Reply-To: <20091007.213915.37481688.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0910081515160.2356@oizys.tordivel.org>
References: <Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
	<20091007.140938.255120957.davem@davemloft.net>
	<Pine.LNX.4.60.0910080155210.12519@mailgate.netunix.com>
	<20091007.213915.37481688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: sammy@sammy.net, sfr@canb.auug.org.au, julian.calaby@gmail.com,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	crn@netunix.com, microblaze-uclinux@itee.uq.edu.au,
	wmb@firmworks.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 7 Oct 2009, David Miller wrote:

> From: Chris Newport <crn@netunix.com>
> Date: Thu, 8 Oct 2009 02:29:25 +0100 (BST)
>
>> Sun4d has never had SMP support and
>
> Wrong.
>
>> this is apparantly problematic due to Cray interlectual property
>>  causing a lack of bus documentation.
>
> XBUS documentation is not available, but we fully know how to
> program the SBUS interrupt controller and whatnot.  It's all
> there in the sun4d interrupt and SMP support and it did work
> just fine at one point.
>
> Amusingly the SBUS interrupt stuff on sun4d is a very close
> sibling to the IMAP/ICLR scheme used on sun4u.
>

The Sun4d SMP support exists, but is broken in 2.6.
And the UP support is buggy. At least on my test-setup, the
kernel is unable to load userland from scsi-drives.

Dropping the sun4 32-bit SPARC is a bit counterproductive when
considering the resent effort to unify sparc64 and sparc
arch-branches ?
