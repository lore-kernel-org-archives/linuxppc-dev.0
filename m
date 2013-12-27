Return-Path: <olof@lixom.net>
Received: from mail-qe0-f53.google.com (mail-qe0-f53.google.com
 [209.85.128.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28D242C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 08:34:32 +1100 (EST)
Received: by mail-qe0-f53.google.com with SMTP id nc12so9658892qeb.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Dec 2013 13:34:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1388135456.5072.3.camel@x220>
References: <1388123524-9000-1-git-send-email-olof@lixom.net>
 <1388135456.5072.3.camel@x220>
Date: Fri, 27 Dec 2013 13:34:29 -0800
Message-ID: <CAOesGMg9ha3MBXpo3_GM5oKxp-Pm_3LvKz1oJh=FbzgcMh3S5g@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: remove pasemi_nand driver
From: Olof Johansson <olof@lixom.net>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 27, 2013 at 1:10 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Thu, 2013-12-26 at 21:52 -0800, Olof Johansson wrote:
>> The PA Semi platform is sparsely used these days (with just a handful
>> of known users out there). I'm 100% sure none of them use the MTD NAND
>> driver -- most standard use cases include PCI-e SATA controllers for
>> storage instead, and boot is done from LPC NOR flash.
>>
>> So, there's little reason to keep carrying a driver that's not used by
>> anybody and that just gets hit by some tree-wide or tools-based changes
>> every now and then.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>  drivers/mtd/nand/pasemi_nand.c |  238 ----------------------------------------
>>  1 file changed, 238 deletions(-)
>>  delete mode 100644 drivers/mtd/nand/pasemi_nand.c
>
> If this gets accepted we should remove the related entry in
> drivers/mtd/nand/Kconfig and the related line in
> drivers/mtd/nand/Makefile too, shouldn't we?

D'oh. Yes, of course. v2 coming.


-Olof
