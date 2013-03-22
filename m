Return-Path: <B32736@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9560A2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 18:15:18 +1100 (EST)
Message-ID: <514C054E.4080102@freescale.com>
Date: Fri, 22 Mar 2013 15:16:30 +0800
From: Zhicheng Fan <b32736@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] powerpc/dts: Add qe support for 36bit
References: <1363857961-23296-1-git-send-email-B32736@freescale.com>
 <CAOZdJXVs9My50m9KHzdbn6pjvhvLqHrqqMsK02z2kCFx8YB03w@mail.gmail.com>
In-Reply-To: <CAOZdJXVs9My50m9KHzdbn6pjvhvLqHrqqMsK02z2kCFx8YB03w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22/2013 02:42 AM, Timur Tabi wrote:
> On Thu, Mar 21, 2013 at 4:26 AM, Zhicheng Fan <B32736@freescale.com> wrote:
>> +       qe: qe@fffe80000 {
>> +               ranges = <0x0 0xf 0xffe80000 0x40000>;
> Are you sure this works?  The QE can't handle 36-bit addresses, and I
> think the MURAM is located inside the QE address space.
>
Hi Timur,
         you are right ,the QE can not support the 36-bit , I test it on 
the p1025 ,the qe can not work
         but we need the qe node , becase the dts include the 
fsl/p1021si-post.dtsi
         that needed, I will send other patch

-- 
Regards & Thanks
Zhicheng Fan
