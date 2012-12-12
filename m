Return-Path: <monstr@monstr.eu>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69F282C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 03:56:04 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id ik5so503578bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 08:56:00 -0800 (PST)
Message-ID: <50C8B71E.90704@monstr.eu>
Date: Wed, 12 Dec 2012 17:55:58 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <20121210214127.D51773E0796@localhost> <50C85E7D.5080006@monstr.eu>
 <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
In-Reply-To: <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2012 11:49 AM, Grant Likely wrote:
> On Wed, Dec 12, 2012 at 10:37 AM, Michal Simek <monstr@monstr.eu> wrote:
>> On 12/10/2012 10:41 PM, Grant Likely wrote:
>>> drivers/pci/pci-of.c would be good. I'd also accept drivers/of/pci.c
>>> which might actually be a good idea in the short term so that it gets
>>> appropriate supervision while being generalized before being moved into
>>> the pci directory.
>>
>> Ben: Are you willing to move that ppc code to this location?
>> It is probably not good idea that I should do it when I even don't have
>> hardware available for testing (Asking someone else).
>
> You're a clever guy, you are more than capable of crafting the patch,
> even if you can't test on hardware. :-)
>
> I refactored most of the OF support code without having access to most
> of the affected hardware. Once I got the changes out there for review
> I also asked for spot testing before getting it into linux-next for
> even more testing.

Fair enough. :-)

Good time to start to look for how to work with board farm.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
