Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FCA41A0167
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 09:03:13 +1100 (AEDT)
Message-ID: <1455141783.2463.9.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Feb 2016 16:03:03 -0600
In-Reply-To: <CAPk1OjEAMaZjup2UWmtibyDtM1qSH7OuKQqgLV4iDnBm5gF_8g@mail.gmail.com>
References: <CAPk1OjEAMaZjup2UWmtibyDtM1qSH7OuKQqgLV4iDnBm5gF_8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: mpc8641si-pre.dtsi and mpc8641si-post.dtsi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-10 at 15:40 +0100, Alessio Igor Bogani wrote:
> Hi Kumar, Scott and all,
> 
> I'm wondering if actual make sense create files in subject to
> consolidate five device tree (gef_ppc9a.dts, gef_sbc310.dts,
> gef_sbc610.dts, mpc8641_hpcn.dts and sbc8641d.dts). If it makes sense
> what device tree can I take as example?
> 
> Thank you very much!

Yes, and you can use the various 85xx/QorIQ trees as an example.  FWIW, it
should be possible to move the pre content into post, and have only one dtsi.

-Scott
