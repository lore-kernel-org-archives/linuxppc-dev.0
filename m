Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA8602C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 19:08:24 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id q14so6320644eaj.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:08:20 -0700 (PDT)
Message-ID: <51A716FE.9040909@gmail.com>
Date: Thu, 30 May 2013 11:08:14 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Arnaud Ebalard <arno@natisbad.org>
Subject: Re: [PATCH v5 12/13] ARM: kirkwood: remove redundant DT board files
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-13-git-send-email-sebastian.hesselbarth@gmail.com>
 <8738t4q1kv.fsf@natisbad.org>
In-Reply-To: <8738t4q1kv.fsf@natisbad.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/13 11:06, Arnaud Ebalard wrote:
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:
>> With DT support for mv643xx_eth board specific init for some boards now
>> is unneccessary. Remove those board files, Kconfig entries, and
>> corresponding entries in kirkwood_defconfig.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
...
> Just a stupid note: With Thomas ongoing work to get mvebu-pcie driver in
> place and enabled for kirkwood, some boards setup files will also lose
> their pcie init routines, which may allow you to kill those additonal
> files soon.
>
> For instance 6bd98481ab34 (arm: kirkwood: NETGEAR ReadyNAS Duo v2 init
> PCIe via DT) currently sitting in jcooper/mvebu/pcie_kirkwood removes
> the PCIE init routine in board-readynas.c, and yours remove ge00
> init. With both applied, the whole file can go away.
>
> AFAICT, this may be the case soon for:
>
>   arch/arm/mach-kirkwood/board-iconnect.c   (36e5722089)
>   arch/arm/mach-kirkwood/board-mplcec4.c    (9470fbfb8d)
>   arch/arm/mach-kirkwood/board-nsa310.c     (40fa8e5da2)
>   arch/arm/mach-kirkwood/board-readynas.c   (6bd98481ab)
>   arch/arm/mach-kirkwood/board-ts219.c      (259e234608)
>
> Anyway, thanks for this work Sebastian.

Arnaud,

I already realized this when merging Jason's recent PRs and put
mv643xx_eth patches on top. I am aware of it but as ARM part of
mv643xx_eth will be delayed until net part surfaces, we have
plenty of time to react on current updates to mach-kirkwood
boards.

Sebastian
