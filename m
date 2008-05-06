Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 118FEDE252
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 02:01:20 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: Dan Munckton <lists@munckfish.net>
Subject: Re: [Cbe-oss-dev] Xorg crash when PCI not enabled
Date: Tue, 6 May 2008 18:01:15 +0200
References: <20080430215644.655638516@am.sony.com>
	<200805061014.16229.marvin24@gmx.de>
	<1210067053.8444.14.camel@dylan>
In-Reply-To: <1210067053.8444.14.camel@dylan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200805061801.16116.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Dan,

On Tuesday 06 May 2008 11:44:12 Dan Munckton wrote:
> Hi
>
> On Tue, 2008-05-06 at 10:14 +0200, Marvin wrote:
> > p.s. I installed fc9 last week and Xorg crashes when PCI is not
> > enabled. just
> > in case someone has the same problem.
>
> The Ubuntu PS3 team is also working on an a couple of bugs relating to
> lack of PCI info. I don't know if these are the same issues you're
> facing. We're tracking them here at [0] and [2].
>
> We had an initial crash was simple to fix [1]. Now we need to get X to
> automatically load the fbdev driver instead of vesa [2].

Fedora uses a newer Xorg (1.5.0 RC1) then Ubuntu. It seems that the 
detection/scanning code was changed. For me, it crashes right behind "using 
VT number 7", where a file in /sys/bus/pci is accessed (which of course does 
not exist), so its not related to the other mentioned bugs. I'm hesitating to 
file a fedora bug report, because the default kernel works. It's more a Xorg 
bug to assume everyone has PCI ...

Greetings

	Marvin
