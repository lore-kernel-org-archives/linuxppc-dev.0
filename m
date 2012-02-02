Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40ED2B71A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 03:07:19 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: General question : Debugging Kernel on PPC
Date: Thu, 2 Feb 2012 16:07:10 +0000
Message-ID: <CAEsOVNd32ga5D-8Ymo9ZKTzuASk6KNSy2usT9_R7E8E0kM4VhA@mail.gmail.com>
References: <93CD5F41FDBC6042A6B449764F3B35CC050CECE7@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CECE7@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 2, 2012 at 2:59 AM, Arshad, Farrukh
<Farrukh_Arshad@mentor.com> wrote:
> Greetings All,
>
> I have general question regarding kernel debugging on PowerPC platform.
> Except printk what are other ways for kernel / kernel modules debugging o=
n
> PowerPC architecture (i.e P1022DS/RDK boards). I am specifically referrin=
g
> to the option of connecting hardware probe and debug the kernel / kernel
> module via gdb/kgdb or some IDE. Please suggest any probe & IDE which
> provide this facility.

BDI(2|3)000 and gdb works pretty well, then there are USBTAPs from
Freescale and CodeWarrior. You could also use an RTL simulator like
simics for this part which has a lot of advanced features.

-M=
