Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 257DF1007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 08:05:46 +1100 (EST)
Message-ID: <4EA08D20.7010405@freescale.com>
Date: Thu, 20 Oct 2011 16:05:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/2] powerpc/85xx: create dts components to build
 up an SoC
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXWtnBB5=DahG8LGQpeP7or0VZv78duhtPiORk3WOir8gQ@mail.gmail.com>
 <A54F7698-A96F-4EE1-89DB-B6A7C5A071FB@kernel.crashing.org>
In-Reply-To: <A54F7698-A96F-4EE1-89DB-B6A7C5A071FB@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> > How about we put all serial devices into one pq3-duart.dtsi file, and
>> > let the parent dtsi file reference just the ones that it needs?
> there isn't an option to do that w/dtc

What about making all the nodes disabled by default, and then the soc.dtsi
or si.dtsi file can re-enable them?

-- 
Timur Tabi
Linux kernel developer at Freescale
