Return-Path: <anemo@mba.ocn.ne.jp>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.175.29])
	by ozlabs.org (Postfix) with ESMTP id CC0A1DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:09:19 +1000 (EST)
Date: Fri, 06 Apr 2007 00:09:13 +0900 (JST)
Message-Id: <20070406.000913.28784231.anemo@mba.ocn.ne.jp>
To: dwmw2@infradead.org
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1175784435.2719.18.camel@shinybook.infradead.org>
References: <1175696383.2774.24.camel@shinybook.infradead.org>
	<20070405.233101.106261123.anemo@mba.ocn.ne.jp>
	<1175784435.2719.18.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	torben@kernel.org, device@lanana.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Apr 2007 10:47:15 -0400, David Woodhouse <dwmw2@infradead.org> wrote:
> > Is major 204 minor 192 already allocated?
> 
> Of course. The reason it took so long to provide this patch after the
> 'pmac_zilog doesn't load' bug got reported was because I was waiting for
> the new allocation.
> 
> > Few weeks ago, I sent a patch to allocate 192...199 for other serial
> > driver 
> 
> Were those numbers assigned to you or did you just make them up?

What I did is just send a patch includeing devices.txt changes to
lkml, device@lanana.org, and some others.

Maybe I should have sent "request" (not patch) mail to
device@lanana.org first?

---
Atsushi Nemoto
