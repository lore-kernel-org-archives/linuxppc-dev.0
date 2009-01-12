Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 8B782DE0B7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 04:24:04 +1100 (EST)
Received: by bwz3 with SMTP id 3so27726805bwz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 09:24:02 -0800 (PST)
Message-ID: <c384c5ea0901120920u7cd349b3te9c57301d204aa55@mail.gmail.com>
Date: Mon, 12 Jan 2009 18:20:07 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Li Yang" <leoli@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB
	w/FSL U-Boots
In-Reply-To: <C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
	<3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
	<C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Mon, Jan 12, 2009 at 4:07 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> On Jan 12, 2009, at 1:55 AM, Li Yang wrote:
>>> -----Original Message-----
>> Freescale BSP is for customer who needs the out-of-box experience.  It's
>> better tested, but doesn't update very frequently.  I would suggest the
>> customer to use the upstream u-boot, if they decide to use latest
>> upstream kernel.
>>
>
The upstream u-boot did however not support PCI Express, which the
latest Freescale kernel did.

So it was a chicken-egg problem experience for people wanting to test
both the latest Freescale kernel as well as Antov's work to bring the
PCI Express support upstream.

Thanks Antov et al,
-- 
Leon
