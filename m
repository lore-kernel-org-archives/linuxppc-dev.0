Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 538662C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 08:09:27 +1000 (EST)
Message-ID: <5011C00D.7090403@freescale.com>
Date: Thu, 26 Jul 2012 17:09:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com> <1343173422.2218.2.camel@concordia>
 <500F5C99.6060704@freescale.com> <1343193511.2218.10.camel@concordia>
 <5011B673.4030802@freescale.com>
In-Reply-To: <5011B673.4030802@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2012 04:28 PM, Timur Tabi wrote:
> Michael Ellerman wrote:
>> And the bible, K & R, includes an example of an enum which explicitly
>> specifies all its values. It goes on to say "enumeration variables offer
>> the chance of [type] checking and so are often better than #defines".
> 
> I don't want to beat a dead horse here, but if the driver doesn't do enum
> type checking, then it's hard to justify using an enum.

Enum symbols show up in a debugger, which is nice.  Why use the
preprocessor for something that can be just as well expressed in the
language itself?  The only real argument for #define in this case is
style, which in Linux does tend toward favoring #define.

-Scott
