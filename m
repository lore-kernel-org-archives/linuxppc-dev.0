Return-Path: <jhs@mojatatu.com>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F05D31A0358
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 02:09:49 +1100 (AEDT)
Received: by iebtr6 with SMTP id tr6so12922738ieb.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2015 07:09:47 -0800 (PST)
Message-ID: <54F9C339.2050409@mojatatu.com>
Date: Fri, 06 Mar 2015 10:09:45 -0500
From: Jamal Hadi Salim <jhs@mojatatu.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
References: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
 <54F84CF1.80702@mojatatu.com> <54F85ECB.3070200@Freescale.com>
 <54F869CE.1080701@mojatatu.com> <54F87096.2070709@Freescale.com>
In-Reply-To: <54F87096.2070709@Freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Emil,

On 03/05/15 10:04, Emil Medve wrote:
> Hello Jamal,
>
>
> On 03/05/2015 08:35 AM, Jamal Hadi Salim wrote:
>> Hi Emil,
>>
>
> No. All the kernel drivers/code we want to upstream is meant to stand on
> its own and be used the "normal" Linux/Unix way
>

Ok, thanks - that was my only concern.
Note there is a lot of offload efforts going on in Linux right now.
Take a look at the proceedings from netdev01. You should take advantage
of that to shape the direction of your patches.
I have suffered at the hands of the sdk for this processor in the past;
it is just a bad idea to keep these SDKs around when Linux can express
the features sufficiently.
Note: The main thing i'd be interested in is when you get to offloading
the classifier/scheduler etc. I know you are focussing on just the 
ethernet level at the moment,

cheers,
jamal
