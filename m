Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id C0CE7DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 01:54:44 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2599532nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Mar 2007 08:54:42 -0700 (PDT)
Message-ID: <528646bc0703260854h2350c762re706371db1b3dd8f@mail.gmail.com>
Date: Mon, 26 Mar 2007 09:54:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen@coderock.org>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
In-Reply-To: <20070326132308.GD3846@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
	<528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
	<20070315163648.GG19297@nd47.coderock.org>
	<20070322074109.GA4620@moe.telargo.com>
	<20070326132308.GD3846@nd47.coderock.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/26/07, Domen Puncer <domen@coderock.org> wrote:
> On 22/03/07 08:41 +0100, Domen Puncer wrote:
> > On 15/03/07 17:36 +0100, Domen Puncer wrote:
> > > Well... the code is only applicable for Lite5200b/mpc5200
> > > and numbers are from specs.
> > > And it's shorter than mpc52xx_find_and_map() lines.
> > > I guess I could rewrite it.
> >
> > In asm code I need access to SDRAM controller registers (MBAR+0x100).
> > Do I add an entry to dts, or do you have other suggestions?

Fair enough; this is chip-specific code after all; not device driver
code.  MBAR must always be retrieved from the device tree, but these
offsets from MBAR will never move, so you don't need to pull them from
the device tree.  At least comment it as to where the numbers came
from.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
