Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
In-reply-to: <4F26274B.2040401@gmx.de>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org> <4F26274B.2040401@gmx.de>
Date: Mon, 06 Feb 2012 09:25:28 +1100
Message-ID: <8068.1328480728@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4F26274B.2040401@gmx.de> you wrote:
> On 01/16/2012 03:08 AM, Michael Neuling wrote:
> [...]
> > From: Michael Neuling <mikey@neuling.org>
> > 
> > [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
> > 
> > Fix a compiler errors introduced in:
> >   commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
> >   Author: Timur Tabi <timur@freescale.com>
> >   drivers/video: fsl-diu-fb: merge all allocated data into one block
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> Applied.

Florian,

I've not seen this appear in mainline as yet.  

When do you expect to send a pull request?

Mikey
