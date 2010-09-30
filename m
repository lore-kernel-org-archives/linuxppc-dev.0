Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8E764B70A7
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 00:16:32 +1000 (EST)
Received: by iwn37 with SMTP id 37so2878966iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 07:16:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 30 Sep 2010 23:16:09 +0900
Message-ID: <AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
To: David Brownell <david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>,
	linux-mtd@lists.infradead.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2010 at 7:46 PM, David Brownell <david-b@pacbell.net> wrote:
>
> --- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:
>
>> From: Mingkai Hu <Mingkai.hu@freescale.com>
>> Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by page
>
> NAK.
>
> We went over this before.

Yes, I agree with David on this.  If large transfers don't work, then
it is the SPI master driver that is buggy.

g.
