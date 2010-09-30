Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 0BD1AB6F0D
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 06:57:43 +1000 (EST)
Received: by iwn37 with SMTP id 37so3317458iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 13:57:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100930150633.GA13741@oksana.dev.rtsoft.ru>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
	<AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
	<20100930150633.GA13741@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 Oct 2010 05:57:21 +0900
Message-ID: <AANLkTim2osW_BoOOUZ4EXx7P=qK3-23Co+Mdj7kLRyt4@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 12:06 AM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Thu, Sep 30, 2010 at 11:41:40PM +0900, Grant Likely wrote:
>> On Thu, Sep 30, 2010 at 11:16 PM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>> > On Thu, Sep 30, 2010 at 7:46 PM, David Brownell <david-b@pacbell.net> =
wrote:
>> >>
>> >> --- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:
>> >>
>> >>> From: Mingkai Hu <Mingkai.hu@freescale.com>
>> >>> Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read pag=
e by page
>> >>
>> >> NAK.
>> >>
>> >> We went over this before.
>> >
>> > Yes, I agree with David on this. =A0If large transfers don't work, the=
n
>> > it is the SPI master driver that is buggy.
>>
>> By the way, does this fix your problem?
>>
>> https://patchwork.kernel.org/patch/184752/
>
> It shouldn't. AFAIK, eSPI is PIO-only controller, and the overrun
> fix is for the DMA mode.
>
> Thanks,
>
> p.s. Btw, in patch 3/7, is_dma_mapped argument of fsl_espi_bufs()
> is unneeded.

Thanks Anton.  Please reply to that patch with this comment so that
patchwork records it and I don't forget about it.

Thanks,
g.

>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
