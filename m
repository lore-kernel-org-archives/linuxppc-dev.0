Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 793781A0615
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 21:27:52 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 0665A440DA4_6D96323B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:27:47 +0000 (GMT)
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 1C5DA43E085_6D96309F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:27:21 +0000 (GMT)
Received: by mail-qk0-f179.google.com with SMTP id s68so19065409qkh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Mar 2016 02:27:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1457038028.5360.98.camel@buserror.net>
References: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
 <1457038028.5360.98.camel@buserror.net>
Date: Fri, 4 Mar 2016 11:27:19 +0100
Message-ID: <CAPk1OjFFHemnN5BPzX10PeJaNkZEJ=dgs6fUdz=ZSkX=NTUaGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] powerpc/86xx: Move dts files to fsl directory
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On 3 March 2016 at 21:47, Scott Wood <oss@buserror.net> wrote:
> On Wed, 2016-03-02 at 13:16 +0100, Alessio Igor Bogani wrote:
>> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> ---
>> v2 -> v3
>>     Use appropriate git format-patch flag "-M" to detect renames
>>
>> v1 -> v2
>>     Address suggestion made by Scott Wood
>>           Split the second patch in two
>>           Don't remove "fsl,mpic" which it is required for 4-cell
>>             interrupt specifiers
>>           Remove pointless compatible in the dtsi
>>           Use the right value for pcie clock-frequency (100 Mhz)
>
> This patchset looks OK -- were you going to send a non-RFC version?  Or do you
> want me to apply this one?

I have just sent you a non-RFC version. Thanks!

Ciao,
Alessio
