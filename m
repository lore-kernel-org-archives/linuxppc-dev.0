Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D61BBB71A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 06:44:30 +1000 (EST)
Subject: Re: [PATCH 0/7] This patchset adds support for running Linux under
	the Freescale hypervisor,
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305813272-31826-1-git-send-email-timur@freescale.com>
Date: Fri, 20 May 2011 15:29:08 -0500
Message-ID: <A221B293-A4DD-4223-AEEA-F3E5243D2C0A@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2011, at 8:54 AM, Timur Tabi wrote:

> have hypervisor extensions (e.g. the P4080 which has an e500mc core).
>=20
> I think it makes sense for this patchset to go through Kumar Gala's =
-next=20
> branch, but I still need ACKs from various people on the parts that =
are
> not e500-specific.
>=20
> 1. powerpc: make irq_choose_cpu() available to all PIC drivers
> 2. powerpc: introduce ePAPR embedded hypervisor hcall interface
> 3. powerpc: introduce the ePAPR embedded hypervisor vmpic driver
> 4. powerpc: add Freescale hypervisor partition control functions
> 5. powerpc/85xx: add board support for the Freescale hypervisor
> 6. tty/powerpc: introduce the ePAPR embedded hypervisor byte channel =
driver
> 7. drivers/misc: introduce Freescale hypervisor management driver
>=20
> Ben Herrenschmidt, please review/ack parts 1-3.
>=20
> Greg Kroah-Hartman, please review/ack part 6.
>=20
> Andrew Morton, please review/ack part 7.
>=20
> Thank you very much for looking at this patchset.  I hope to have it =
included=20
> in 2.6.40.

Applied to 'test' branch.  (grabbed 'v2' of tty patch).  Fixed merged =
conflicts.

- k=
