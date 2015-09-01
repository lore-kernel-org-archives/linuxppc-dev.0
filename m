Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E6BF1A0725
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 11:31:30 +1000 (AEST)
Message-ID: <1441071089.26730.4.camel@ellerman.id.au>
Subject: Re: [Question] Is little endian supported on all the platforms?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Geoff Levand <geoff@infradead.org>, Anatolij
 Gustschin <agust@denx.de>,  Alistair Popple <alistair@popple.id.au>, Matt
 Porter <mporter@kernel.crashing.org>, Vitaly Bordug
 <vitb@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, Kumar
 Gala <galak@kernel.crashing.org>, Olof Johansson <olof@lixom.net>, Arnd
 Bergmann <arnd@arndb.de>
Date: Tue, 01 Sep 2015 11:31:29 +1000
In-Reply-To: <1441053636.2720.21.camel@kernel.crashing.org>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
 <1441019966.31779.1.camel@ellerman.id.au>
 <1441053636.2720.21.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-01 at 06:40 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2015-08-31 at 21:19 +1000, Michael Ellerman wrote:
> 
> > Yes. Maybe something like this?
> 
> I would have done it the other way around with endian at the top
> and only the supported platforms displayed based on the endian...
> 
> But I don't care *that* much either way

Yeah, I figured folks are not really caring so much about endian when
configuring they're primarily thinking about the platform.

But if we do it this way we *also* need to make PS3 etc. depend on
BIG_ENDIAN, so they don't get enabled on multi-platform LE builds, so we should
probably just do it that way.

cheers
