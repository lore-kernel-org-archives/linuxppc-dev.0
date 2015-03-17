Return-Path: <peter@hurleysoftware.com>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434BB1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:58:37 +1100 (AEDT)
Received: by qcyi15 with SMTP id i15so62694713qcy.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 19:58:35 -0700 (PDT)
Message-ID: <55079859.1020205@hurleysoftware.com>
Date: Mon, 16 Mar 2015 22:58:33 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Pranith Kumar <bobby.prani@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux panic on 4.0.0-rc4
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
In-Reply-To: <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2015 10:02 PM, Pranith Kumar wrote:
> On Mon, Mar 16, 2015 at 7:22 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> The log shows that init is being killed, that's what's causing the panic.
>>
>> The exitcode of init is 0x200, which due to the vagaries of UNIX is I think an
>> "exit status" of 2 in the common usage.
>>
>> But it suggests that your init is just exiting for some reason?
>>
> 
> Yeah, seems like that. Not sure why though. git bisect seems to be the
> only option.
> 
>> What is your init?
> 
> I am using systemd from debian unstable.

Do you have a stdout-path property defined in your dts to a serial
console you're not actually using?
