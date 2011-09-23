Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3D10B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 03:56:52 +1000 (EST)
Message-ID: <4E7CC859.2000706@freescale.com>
Date: Fri, 23 Sep 2011 12:56:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH v2] powerpc: Fix xmon for systems without MSR[RI]
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
	<1316790104-10067-1-git-send-email-jimix@pobox.com>
	<4E7CB4B1.3080703@freescale.com>
	<72989FF4-07B5-4BAC-BD9C-FE768296FDD8@pobox.com>
In-Reply-To: <72989FF4-07B5-4BAC-BD9C-FE768296FDD8@pobox.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2011 12:54 PM, Jimi Xenidis wrote:
> On Sep 23, 2011, at 11:32 AM, Scott Wood wrote:
>> How is CONFIG_BOOK3E better than CONFIG_BOOKE?  Both e500mc (has RI) and
>> e500v2 (doesn't have RI) will select both symbols.  Sounds like it
>> should be a cputable flag.
> 
> Ben was not in favor of wasting a cpu feature bit on this.

That we're discussing the wastage of a single *bit* suggests the CPU
feature mechanism could use an overhaul. :-P

-Scott
