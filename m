Return-Path: <tommusta@gmail.com>
Received: from mail-qa0-x232.google.com (mail-qa0-x232.google.com
 [IPv6:2607:f8b0:400d:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DE0F2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 00:29:32 +1100 (EST)
Received: by mail-qa0-f50.google.com with SMTP id f11so202335qae.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2013 05:29:29 -0800 (PST)
Message-ID: <5277A130.6040306@gmail.com>
Date: Mon, 04 Nov 2013 07:29:20 -0600
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads
 and Stores
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>	
 <1383244738-5986-4-git-send-email-tommusta@gmail.com>
 <1383532491.4776.42.camel@pasglop>
In-Reply-To: <1383532491.4776.42.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/3/2013 8:34 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-10-31 at 13:38 -0500, Tom wrote:
>> From: Tom Musta <tommusta@gmail.com>
>>
>> This patch addresses unaligned single precision floating point loads
>> and stores in the single-step code.  The old implementation
>> improperly treated an 8 byte structure as an array of two 4 byte
>> words, which is a classic little endian bug.
> 
> Do that patch differ from v1 ? I also already merged v1 of this
> one (the only one I didn't merge is the emulate_step one)
> 
> Cheers,
> Ben.
>

Ben:  Only patch 1/3 (Enable emulate_step in Little Endian Mode) differs in V2.
