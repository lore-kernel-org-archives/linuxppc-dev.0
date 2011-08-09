Return-Path: <B07421@freescale.com>
Message-ID: <4E419180.3090507@freescale.com>
Date: Tue, 9 Aug 2011 14:58:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
References: <1312901031-29887-1-git-send-email-holt@sgi.com>
	<1312901031-29887-6-git-send-email-holt@sgi.com>
	<4E4179CB.6030101@freescale.com> <20110809184524.GB4926@sgi.com>
	<4E4186BD.5000602@freescale.com> <4E418F2D.4060504@grandegger.com>
In-Reply-To: <4E418F2D.4060504@grandegger.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 02:49 PM, Wolfgang Grandegger wrote:
> Yes. The doc for the bindings we speak about
> 
> http://lxr.linux.no/#linux+v3.0.1/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> 
> sneaked into the kernel without been presented on any mailing list and
> without the corresponding driver patch.

It was posted on linuxppc-dev:
http://patchwork.ozlabs.org/patch/91980/

Though I agree it should have been posted more widely.

> OK, just
> 
>   "fsl,p1010-flexcan"
> 
> or
> 
>   "fsl,p1010-flexcan", "fsl,flexcan"

I'm ok with the latter, if there's enough in common that it's
conceivable that a driver wouldn't care.  The more specific compatible
will be there if the driver wants to make use of it later.

-Scot
