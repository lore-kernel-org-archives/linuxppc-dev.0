Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3962B6F95
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Sep 2011 08:44:00 +1000 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc: Fix build dependencies for epapr.c which needs
	libfdt.h
Date: Tue, 13 Sep 2011 22:43:54 +0000
Message-ID: <CAEsOVNcw8WaRH+q4hfigDt_KF78TaUNAXqd7-y_HmRryLqK5yA@mail.gmail.com>
References: <1311092564-10102-1-git-send-email-msm@freescale.com>
	<20110720134907.GN6399@yookeroo.fritz.box>
In-Reply-To: <20110720134907.GN6399@yookeroo.fritz.box>
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

On Wed, Jul 20, 2011 at 8:49 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Jul 19, 2011 at 11:22:44AM -0500, Matthew McClintock wrote:
>> Currently, the build can (very rarely) fail to build because libfdt.h ha=
s
>> not been created or is in the process of being copied.
>>
>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>
> Looks sane to me.

ping? I'm still seeing this issue.

-M=
