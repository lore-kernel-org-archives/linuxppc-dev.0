Return-Path: <peter@hurleysoftware.com>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82DD61A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 14:18:32 +1100 (AEDT)
Received: by qcbkw5 with SMTP id kw5so62973392qcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 20:18:30 -0700 (PDT)
Message-ID: <55079D05.8020302@hurleysoftware.com>
Date: Mon, 16 Mar 2015 23:18:29 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
 <55079859.1020205@hurleysoftware.com>
 <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
In-Reply-To: <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
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

On 03/16/2015 11:12 PM, Pranith Kumar wrote:
> On Mon, Mar 16, 2015 at 10:58 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> What is your init?
>>>
>>> I am using systemd from debian unstable.
>>
>> Do you have a stdout-path property defined in your dts to a serial
>> console you're not actually using?
>>
> 
> I am using tty0 as my console. From the config which I posted, it has:
> 
> CONFIG_CMDLINE="console=ttyS0,9600 console=tty0"
> 
> I am not using any device tree file.

Ok; there was some reported breakage on PowerMac wrt to 'stdout-path'
changes I made, so I thought I'd check if that might have affected
your setup as well.

Regards,
Peter Hurley
