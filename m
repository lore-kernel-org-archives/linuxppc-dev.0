Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91906B70CD
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 12:43:04 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 19 Sep 2010 12:42:53 +1000
Message-ID: <1284864173.30449.111.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <B04825@freescale.com>,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-09-18 at 10:34 -0500, Kumar Gala wrote:
> On Sep 18, 2010, at 9:36 AM, Tabi Timur-B04825 wrote:
> 
> > On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> > 
> >> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
> >>> I don't see any reason to limit it to GPL drivers.  Not only that, but
> >>> then we'll have this:
> >> 
> >> I do
> > 
> > Can you elaborate on that, or are you just going to pull rank on me?
> > 
> >> 
> >>> EXPORT_SYMBOL(ppc_proc_freq);
> >>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
> >>> 
> >>> That just looks dumb. 
> >> 
> >> Right, so send a patch to fix the first one too :-)
> 
> I don't think either of these should be EXPORT_SYMBOL_GPL.  Why
> shouldn't a binary module be allowed to know these frequencies?  My
> view is why preclude anyone from using this how they want.  If they
> want to live in the gray area so be it.  Who am I to say they
> shouldn't have that choice.

Well, I'm all for making binary modules life as hard as possible just
for the sake of it :-)

Cheers,
Ben.
