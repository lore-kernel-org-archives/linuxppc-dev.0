Return-Path: <scottwood@freescale.com>
Message-ID: <488FA22C.5060100@freescale.com>
Date: Tue, 29 Jul 2008 18:05:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: verbose kernel debug
References: <9e4733910807291547p3ddd6b15nbe4516657e2e014f@mail.gmail.com>
In-Reply-To: <9e4733910807291547p3ddd6b15nbe4516657e2e014f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> I'm getting a "Badness at c01cc228 [verbose debug info unavailable]"
> 
> How do I turn on verbose debug support? Or is it helpful? I see the
> option for x86 but I don't see how to do it for PowerPC.

Under "Kernel Hacking", enable "Kernel debugging".  This will expose a 
"Verbose BUG() reporting" option.

IMHO, this option shouldn't be buried in this manner; it's not just for 
hacking kernels, but also for submitting decent bug reports.

-Scott
