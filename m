Return-Path: <B07421@freescale.com>
Date: Mon, 20 Jun 2011 10:59:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc: add support for MPIC message register API
Message-ID: <20110620105946.23708a43@schlenkerla.am.freescale.net>
In-Reply-To: <1308351533.32158.61.camel@pasglop>
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>
	<1306869543-18812-3-git-send-email-meador_inge@mentor.com>
	<1308288784.32158.30.camel@pasglop>
	<20110617115828.3cebd5c9@schlenkerla.am.freescale.net>
	<1308351533.32158.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Meador Inge <meador_inge@mentor.com>, openmcapi-dev@googlegroups.com,
	devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 18 Jun 2011 08:58:53 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2011-06-17 at 11:58 -0500, Scott Wood wrote:
> > When did this change from "considered an internal implementation
> > issue, and not really an interface" to "all new interfaces"?
> 
> Interesting blurb... that's not everybody's opinion and I would argue
> that supporting AMP kernels isn't something we want to do with closed
> source crap.

I'm not advocating "closed source crap", just that if something is
"policy" (as opposed to opinion), it'd be nice if the documentation
actually matched.

-Scott
