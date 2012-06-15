Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81FC4B7095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 04:12:09 +1000 (EST)
Message-ID: <4FDB7AEC.2010102@freescale.com>
Date: Fri, 15 Jun 2012 13:11:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: telenn barz <telenn.barz@gmail.com>
Subject: Re: Questions on Hugetlb for bookE and PHYS_64BIT
References: <CAE2rjsQpZzMaJQrNQexy7kUSVR6F09Nsuxi6ueKiLAh=Hj-G4Q@mail.gmail.com>
In-Reply-To: <CAE2rjsQpZzMaJQrNQexy7kUSVR6F09Nsuxi6ueKiLAh=Hj-G4Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/2012 09:43 AM, telenn barz wrote:
> Hi all,
> 
> CONFIG_PHYS_64BIT enables kernel support for larger than 32-bit physical
> addresses. Is it this configuration option we have to enable for the
> support of 36-bit real memory (as are capable the Freescale e500v2 or
> e500mc cores family) ?

Yes.

> The Hugetlb patch for BookE
> (https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-June/091315.html)
> seems to be surbordinated to CONFIG_PHYS_64BIT. Is there any good reason
> why it is not supported when CONFIG_PHYS_64BIT is disabled ?

Because it would be extra work to support that configuration, and
nobody's felt enough of a need for it to put in that work.

-Scott
