Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC5AD1400A1
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2014 10:05:26 +1100 (EST)
Message-ID: <1395788711.12738.3.camel@snotra.buserror.net>
Subject: Re: Ask for help about fsl ppc toolchian issue "Illegal instruction"
From: Scott Wood <scottwood@freescale.com>
To: wyang <w90p710@gmail.com>
Date: Tue, 25 Mar 2014 18:05:11 -0500
In-Reply-To: <533114A4.4080608@gmail.com>
References: <BLU172-W4881D62A1C46E030116284FD650@phx.gbl>
 <533114A4.4080608@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: =?UTF-8?Q?=E8=AE=B8=E4=B9=85=E6=88=90?= <jiucheng.xu@hotmail.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-25 at 13:31 +0800, wyang wrote:
> 
> On 03/25/2014 10:17 AM, 许久成 wrote:
> 
> > Hi All, 
> > 
> > 
> > We run into an issue when use e500mc toolchain  g++ to compile c++
> > code for p2020 platform,  the code as below:
> 
> Hmm, p2020 should be e500 core rather than e500mc. Additionally, you
> should use gdb to debug it, and check which instruction is illegal.

It's probably a floating point instruction.  e500v2 (and thus p2020)
does not support normal PPC floating point.  You need to use the right
toolchain.

-Scott
