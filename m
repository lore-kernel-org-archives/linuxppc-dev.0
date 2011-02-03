Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 0/3] powerpc: Open PIC binding and 'no-reset'
	implementation
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
Date: Thu, 3 Feb 2011 09:22:53 -0600
Message-Id: <D6C286E3-9D14-4C11-9974-61DDAB7CB6E2@kernel.crashing.org>
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
To: Meador Inge <meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 2, 2011, at 7:51 PM, Meador Inge wrote:

> This patch set provides a binding for Open PIC and implements support =
for
> a new property, specified by that binding, called 'no-reset'.  With =
'no-reset'
> in place the 'protected-sources' property is no longer needed and was =
removed.
>=20
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> CC: Hollis Blanchard <hollis_blanchard@mentor.com>
>=20
> Meador Inge (3):
>  powerpc: Removing support for 'protected-sources'
>  powerpc: document the Open PIC device tree binding
>  powerpc: make MPIC honor the 'no-reset' device tree property
>=20
> Documentation/powerpc/dts-bindings/open-pic.txt |  115 =
+++++++++++++++++++++++
> arch/powerpc/include/asm/mpic.h                 |    7 +-
> arch/powerpc/sysdev/mpic.c                      |   92 =
++++++++----------
> 3 files changed, 160 insertions(+), 54 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt
>=20

Please cleanup all the .dts that are impacted by this.

- k
