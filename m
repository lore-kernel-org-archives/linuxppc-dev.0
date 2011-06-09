Return-Path: <meador_inge@mentor.com>
Message-ID: <4DF0DC3A.1040300@mentor.com>
Date: Thu, 09 Jun 2011 09:44:10 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, galak@kernel.crashing.org
Subject: Re: [openmcapi-dev] [PATCH v3 0/2] powerpc: define and implement
	MPIC message register support
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: openmcapi-dev@googlegroups.com, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2011 02:19 PM, Meador Inge wrote:

> This patch set defines a binding for FSL MPIC message registers and implements
> an API for accessing those message registers.  Testing was done on a MPC8572DS
> in an Linux-Linux AMP setup using OpenMCAPI (www.openmcapi.org) to communicate
> between OS instances.  The message register API is used by the OpenMCAPI shared 
> memory driver to send notifications between cores.
> 
> * v3 - Clarified a point in the binding concerning the length of the
>        'interrupts' property.  Pointed out by Scott Wood.
> 
> * v2 - Incorporate feedback from Scott Wood
>    * Make binding less implementation specific.
>    * Add 'mpic-' prefix to message register node properties and aliases.
>    * Remove 'interrupt-parent' from binding.
>    * Fixed some example bugs with receive masks.
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> 
> Meador Inge (2):
>   powerpc: document the FSL MPIC message register binding

The binding has been acked (Thanks Scott).

>   powerpc: add support for MPIC message register API

Scott, Kumar, are you all OK with the
implementation: http://patchwork.ozlabs.org/patch/98075/ ?


-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
