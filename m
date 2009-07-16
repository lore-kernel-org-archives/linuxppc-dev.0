Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9427DB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 07:21:53 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 365DBDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 07:21:53 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/2] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40907151018n194a154cmb8549c98c673d2bb@mail.gmail.com>
References: <1247578966-9847-1-git-send-email-wd@denx.de>
	<1247671133-12148-2-git-send-email-wd@denx.de>
	<fa686aa40907151018n194a154cmb8549c98c673d2bb@mail.gmail.com>
Date: Thu, 16 Jul 2009 23:21:50 +0200
Message-Id: <20090716212150.B0DF0832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40907151018n194a154cmb8549c98c673d2bb@mail.gmail.com> you wrote:
> On Wed, Jul 15, 2009 at 9:18 AM, Wolfgang Denk<wd@denx.de> wrote:
> > This patch adds error checking and prevents clobbering unrelated bits
> > (reserved bits or the DIS_PREAMBLE bit) when writing the MII_SPEED
> > register on MPC52xx systems.
...
> As I mentioned in the other patch, I don't want the 5121 and 5200 FEC
> devices using common code for this.  It is a tiny block of code and
> they are different devices.  Just open code the needed calculation
> into this driver.

OK, will do.
