Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D09F8B7723
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:41:53 +1000 (EST)
Subject: Re: [PATCH 2/7] powerpc: introduce ePAPR embedded hypervisor hcall
	interface
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305813272-31826-3-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:41:34 -0500
Message-ID: <A51DF224-1AB1-43CA-8880-253D7FD837B5@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-3-git-send-email-timur@freescale.com>
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

> ePAPR hypervisors provide operating system services via a "hypercall"
> interface.  The following steps need to be performed to make an hcall:
>=20
> 1. Load r11 with the hcall number
> 2. Load specific other registers with parameters
> 3. Issue instrucion "sc 1"
> 4. The return code is in r3
> 5. Other returned parameters are in other registers.
>=20
> To provide this service to the kernel, these steps are wrapped in =
inline
> assembly functions.  Standard ePAPR hcalls are in epapr_hcalls.h, and =
Freescale
> extensions are in fsl_hcalls.h.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/epapr_hcalls.h |  502 +++++++++++++++++++++++
> arch/powerpc/include/asm/fsl_hcalls.h   |  655 =
+++++++++++++++++++++++++++++++
> 2 files changed, 1157 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/include/asm/epapr_hcalls.h
> create mode 100644 arch/powerpc/include/asm/fsl_hcalls.h

applied to next

- k=
