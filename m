Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C87161A0041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 04:29:40 +1000 (EST)
Message-ID: <1401820168.6603.306.camel@snotra.buserror.net>
Subject: Re: FMD15 and t104x
From: Scott Wood <scottwood@freescale.com>
To: Tony <blacklites@gmail.com>
Date: Tue, 3 Jun 2014 13:29:28 -0500
In-Reply-To: <CAE1uq6sUdG3fFYSdagSdROUpdNeRi8Prg5mfr088jxg5SWM3LQ@mail.gmail.com>
References: <CAE1uq6sUdG3fFYSdagSdROUpdNeRi8Prg5mfr088jxg5SWM3LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-03 at 12:13 +0530, Tony wrote:
> Hi,
> 
> I am working with 3.0.x kernel with fmd15. I could bringup the
> t1040qsd but the ethernet is not getting detected. Is t104x devices
> required backporting of FMD19 ? OR modifying the dts file is enough ?

Please use support@freescale.com or https://community.freescale.com/ for
support of the QorIQ SDK.

That said, I'm pretty sure the FMan code from any 3.0-based SDK will not
work with t1040.

-Scott
