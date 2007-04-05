Return-Path: <anemo@mba.ocn.ne.jp>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.175.29])
	by ozlabs.org (Postfix) with ESMTP id 33144DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:49:41 +1000 (EST)
Date: Fri, 06 Apr 2007 00:49:39 +0900 (JST)
Message-Id: <20070406.004939.89276671.anemo@mba.ocn.ne.jp>
To: dwmw2@infradead.org
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1175786292.2719.23.camel@shinybook.infradead.org>
References: <1175784435.2719.18.camel@shinybook.infradead.org>
	<20070406.000913.28784231.anemo@mba.ocn.ne.jp>
	<1175786292.2719.23.camel@shinybook.infradead.org>
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

On Thu, 05 Apr 2007 11:18:12 -0400, David Woodhouse <dwmw2@infradead.org> wrote:
> > Maybe I should have sent "request" (not patch) mail to
> > device@lanana.org first?
> 
> Well, that's what it says right underneath the line in devices.txt which
> says:
> 	**** DEVICE DRIVERS AUTHORS PLEASE READ THIS ****
> 
> It goes on to say...
> 
> "Third, please don't assume that the distributed version of the list is
> up to date.  Due to the number of registrations I have to maintain it
> in "batch mode", so there is likely additional registrations that
> haven't been listed yet."

Thank you, I see.  I'll revoke the patch in -mm tree and send a
request for minor numbers.

---
Atsushi Nemoto
