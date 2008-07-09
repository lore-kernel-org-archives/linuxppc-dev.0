Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 04F73DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 09:57:06 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2975498rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 16:57:04 -0700 (PDT)
Message-ID: <4b73d43f0807091657g45c84d0cua35bbdaecaa361ae@mail.gmail.com>
Date: Wed, 9 Jul 2008 17:57:04 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Two pci patches that are prereq's for MPC5121 pci
In-Reply-To: <1215640375.4392.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4b73d43f0807091407w31280a43tbd07ec8a1aca1a93@mail.gmail.com>
	<1215640375.4392.0.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 9, 2008 at 3:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2008-07-09 at 15:07 -0600, John Rigby wrote:
>> Ben,
>>
>> Could you pick up these two powerpc pci patches.  Grant Likely ack'd
>> them both. No one nak'd them.
>>
>> powerpc: pci config cleanup [rev2]
>> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19299
>
> Hrm.. I'm not necessarily fan of the above but I'll give a second look.
>
I have no particular attachment to this.  In my first attempt I just
added 5121 to the existing mess, Kumar asked if it could be cleaned
up.  Looks like I can please about one person at a time, but no more
than one:).
>> powerpc: Move mpc83xx_add_bridge to fsl_pci.c [rev2]
>> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19300
>
> FSL stuff though go via Kumar.
Ok.  Kumar can you pick this up?  PCI for 5121 needs it.
>
> Cheers,
> Ben.
>
>
>
