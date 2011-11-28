Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3427CB6F70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 06:31:54 +1100 (EST)
Message-ID: <4ED3E168.5000002@freescale.com>
Date: Mon, 28 Nov 2011 13:30:48 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
 <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
In-Reply-To: <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2011 10:23 AM, Josh Boyer wrote:
> On Mon, Nov 28, 2011 at 11:04 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> Since you're fixing this can you add the following for CONFIG_BOOKE:
>>
>> MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM
> 
> Those don't exist on 4xx, so CONFIG_BOOKE doesn't seem appropriate.

They're defined by book3e of ISA 2.06.

Not all bits are going to exist on all CPUs -- does 4xx use these bits
to mean something different?

-Scott
