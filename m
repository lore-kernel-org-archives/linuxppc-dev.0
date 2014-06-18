Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id AC5F91A016B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 14:41:15 +1000 (EST)
Message-ID: <53A1185E.6080707@roeck-us.net>
Date: Tue, 17 Jun 2014 21:41:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.16-rc1
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
In-Reply-To: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sparclinux <sparclinux@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Michal Simek <monstr@monstr.eu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2014 08:23 AM, Geert Uytterhoeven wrote:
> On Tue, Jun 17, 2014 at 5:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
[...]
>
>>    + /scratch/kisskb/src/sound/soc/fsl/fsl_dma.c: error: invalid use of undefined type 'struct ccsr_ssi':  => 926:34, 927:34
>
> powerpc/mpc85xx_defconfig
>

Being fixed:
	http://patchwork.ozlabs.org/patch/358500/

Guenter
