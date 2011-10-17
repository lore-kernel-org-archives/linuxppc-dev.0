Return-Path: <jaswinder.singh@linaro.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E1D23B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 02:52:57 +1100 (EST)
Received: by qyk31 with SMTP id 31so1304488qyk.17
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 08:52:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318700142.23438.45.camel@vkoul-udesk3>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com>
 <1317492077.1573.1839.camel@vkoul-udesk3>
 <0CE8B6BE3C4AD74AB97D9D29BD24E55202291E40@CORPEXCH1.na.ads.idt.com>
 <1317965252.1573.2238.camel@vkoul-udesk3>
 <0CE8B6BE3C4AD74AB97D9D29BD24E552022D6C9A@CORPEXCH1.na.ads.idt.com>
 <1318700142.23438.45.camel@vkoul-udesk3>
Date: Mon, 17 Oct 2011 21:22:53 +0530
Message-ID: <CAJe_ZhdjMTsqSTDwV_zaAQKmCbjOtRVc951wxqKScaCR-DBG9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] RapidIO: Add DMA Engine support for RIO data
 transfers
From: Jassi Brar <jaswinder.singh@linaro.org>
To: Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, "Bounine,
 Alexandre" <Alexandre.Bounine@idt.com>, Dan <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15 October 2011 23:05, Vinod Koul <vinod.koul@intel.com> wrote:

> Another alternate approach could be to add one more argument to
> prep_slave_sg API which allows us to pass additional runtime specific
> parameters. This can be NULL and unused for existing drivers and used in
> RIO and any future subsystems which want to use dmaengine.
> Thoughts...?
>
That doesn't sound much different than passing the data via
dma_chan.private during prep_slave_sg. Only now we add to
the number of arguments.
And then either this argument would be RapidIO specific (unfair
to other users) or generic. In latter case what would it look like ?
