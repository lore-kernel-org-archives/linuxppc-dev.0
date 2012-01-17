Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBE611007FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 06:10:12 +1100 (EST)
Message-ID: <4F15C788.2050701@freescale.com>
Date: Tue, 17 Jan 2012 13:10:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2][v2] mtd/nand: Fix IFC driver to support 2K NAND page
References: <1326111866-13120-1-git-send-email-prabhakar@freescale.com>
 <4F0B901C.6020100@freescale.com>
 <C8C27406-1682-4316-97D1-00EFB5898805@kernel.crashing.org>
In-Reply-To: <C8C27406-1682-4316-97D1-00EFB5898805@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2012 12:57 PM, Kumar Gala wrote:
> 
> On Jan 9, 2012, at 7:10 PM, Scott Wood wrote:
> 
>> On 01/09/2012 06:24 AM, Prabhakar Kushwaha wrote:
>>> 1) OOB area should be updated irrespective of NAND page size. Earlier it was
>>> updated only for 512byte NAND page.
>>>
>>> 2) During OOB update fbcr should be equal to OOB size.
>>>
>>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>>> ---
>>> git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)
>>>
>>> This patch is created on top of IFC driver patch (already floated in mailing
>>> list). Please find their link:
>>> http://patchwork.ozlabs.org/patch/133315/
>>> http://patchwork.ozlabs.org/patch/133316/
>>
>> Looks good.
>>
>> -Scott
> 
> Can we not merge all these into one updated IFC NAND patch?

Sure, once we've agreed on what the right fix is for the is_blank issue
(and I think we're pretty close).  It's been useful to see these fixes
as separate patches during the review/iteration phase, though.

-Scott
