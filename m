Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D0031A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 18:33:06 +1000 (AEST)
Message-ID: <1441009895.2720.7.camel@kernel.crashing.org>
Subject: Re: [Question] Is little endian supported on all the platforms?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geoff Levand <geoff@infradead.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>, Vitaly
 Bordug <vitb@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Aug 2015 18:31:35 +1000
In-Reply-To: <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
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

On Mon, 2015-08-31 at 15:53 +0800, Boqun Feng wrote:

> Got it, thank you ;-)
> 
> So should we modify Kconfigs of all the platform to reflect this?

It would make sense to disable all platforms other than pseries and
powernv in LE, yes.

> > But the specific problem you are having looks like a differnet
> > issue
> > with the PS3 boot wrapper.
> > 
> 
> But could the reason of this be that the building process of the PS3
> boot wrapper assumes the kernel is BE?

Possibly something in the makefiles or the asm, I haven't looked.

Cheers,
Ben.
