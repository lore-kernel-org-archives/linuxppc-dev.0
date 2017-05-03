Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHkDV1D9LzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 13:29:46 +1000 (AEST)
Message-ID: <1493782174.25397.31.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: schindele@nentec.de
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 May 2017 22:29:34 -0500
In-Reply-To: <1715435.xdU3769208@sherry>
References: <2666241.ms6yMRjznt@sherry>
 <20170430065543.iamwy5yvk7tcpmc7@home.buserror.net>
 <1715435.xdU3769208@sherry>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Freescale mpc8315 IRQ0 setup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-02 at 14:43 +0200, Juergen Schindele wrote:
> Dear Scott,
> sorry for the delay but i am not very familiar with the formating.
> I passed the patch trough checkpatch.pl and there was no more error.
> pease find patch in attached file.
> Thanks

Documentation/process/submitting-patches.rst explains the way to format and
submit kernel patches.

Also, why the unrelated change to a print statement in ipic_set_irq_type()?

-Scott
