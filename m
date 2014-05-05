Return-Path: <mpe@ellerman.id.au>
Message-ID: <1399268891.4600.3.camel@concordia>
Subject: Re: Boot problems with a PA6T board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Mon, 05 May 2014 15:48:11 +1000
In-Reply-To: <5366649E.4030102@xenosoft.de>
References: <5366649E.4030102@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-05-04 at 18:02 +0200, Christian Zigotzky wrote:
> Hi All,
> 
> The RC 1, 2, and 3 of the kernel 3.15 don't boot on my PA6T board with a 
> Radeon HD 6870 graphics card.
> 
> Screenshot: 
> http://forum.hyperion-entertainment.biz/download/file.php?id=1060&mode=view
> 
> The kernel 3.14 starts without any problems. Has anyone a tip for me, 
> please?

The line that says "starting cpu hw idx 0... failed" looks a little worrying.
Do you see that on 3.14 as well?

Otherwise bisection is probably your best bet.

cheers
