Return-Path: <meador_inge@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A27A8B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 00:22:03 +1000 (EST)
Message-ID: <4DDE6203.10007@mentor.com>
Date: Thu, 26 May 2011 09:21:55 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 0/2] powerpc: define and implement MPIC message register
	support
References: <1305909399-26969-1-git-send-email-meador_inge@mentor.com>
	<BANLkTikvDEG4DSvVMtxa8=i=NV=o=DQLXA@mail.gmail.com>
In-Reply-To: <BANLkTikvDEG4DSvVMtxa8=i=NV=o=DQLXA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Scott, I addressed your feedback in this patch set:

   * 1/2 - http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-May/090405.html
   * 2/2 - http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-May/090406.html

Ben, my Cc for you didn't go through the first time.


> This patch set defines a binding for FSL MPIC message registers and implements
> an API for accessing those message registers.  Testing was done on a MPC8572DS
> in an Linux-Linux AMP setup using OpenMCAPI (www.openmcapi.org) to communicate
> between OS instances.  The message register API is used by the OpenMCAPI shared
> memory driver to send notifications between cores.
> 
> * v2 - Incorporate feedback from Scott Wood
>   * Make binding less implementation specific.
>   * Add 'mpic-' prefix to message register node properties and aliases.
>   * Remove 'interrupt-parent' from binding.
>   * Fixed some example bugs with receive masks.
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> 
> Meador Inge (2):
>  powerpc: document the FSL MPIC message register binding
>  powerpc: add support for MPIC message register API
> 
>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 +++++
>  arch/powerpc/include/asm/mpic_msgr.h               |   35 +++
>  arch/powerpc/platforms/Kconfig                     |    8 +
>  arch/powerpc/sysdev/Makefile                       |    3 +-
>  arch/powerpc/sysdev/mpic_msgr.c                    |  279 ++++++++++++++++++++
>  5 files changed, 386 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>  create mode 100644 arch/powerpc/include/asm/mpic_msgr.h
>  create mode 100644 arch/powerpc/sysdev/mpic_msgr.c
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
