Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AD095B6F84
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 07:28:13 +1100 (EST)
Message-ID: <4ED691D0.7040308@freescale.com>
Date: Wed, 30 Nov 2011 14:28:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/6] powerpc/boot: Add extended precision shifts to the
 boot wrapper.
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
 <1322632107.21641.43.camel@pasglop>
 <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
 <1322684475.29041.2.camel@pasglop>
In-Reply-To: <1322684475.29041.2.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/2011 02:21 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2011-11-30 at 06:45 -0500, Josh Boyer wrote:
>> On Wed, Nov 30, 2011 at 12:48 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>> On Wed, 2011-11-30 at 16:23 +1100, Tony Breeds wrote:
>>>> Code copied from arch/powerpc/kernel/misc_32.S
>>>>
>>>> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
>>>> ---
>>>>  arch/powerpc/boot/div64.S |   52 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 files changed, 52 insertions(+), 0 deletions(-)
>>>
>>> Should we just link with libgcc ? :-)
>>
>> Please tell me you're joking.
> 
> Only half... I wonder what it would look like. Wouldn't ld only pickup
> what we use anyway ?

We do it in U-Boot...

Only problem I see is that it would need to be built as soft-float, and
apparently that isn't supported by gcc on 64-bit ppc.  Unfortunately
there's isn't a "no float" mode.

-Scott
