Return-Path: <gjaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 1A26F67D25
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 21:58:53 +1000 (EST)
From: Gerhard Jaeger <gjaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 26 Jul 2005 13:55:40 +0200
References: <42E6137F.6040605@gmx.de>
In-Reply-To: <42E6137F.6040605@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507261355.40327.gjaeger@sysgo.com>
Cc: Frank Lautenbach <frank.lautenbach@gmx.de>
Subject: Re: Linux on Bamboo
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Dienstag 26 Juli 2005 12:42, Frank Lautenbach wrote:
> Hey folks,
>
> thanks for your hint with mktree, the converted image at least started
> somehow up, I can see
> "TUX!" (btw: can anybody tell the code snipet where this output is
> generated?) on the onboard

--> this is done by PIBS, before starting the kernel img...

> display but the kernel seems to crash very early without any output to
> the terminal...
>
> I think the next hurdle is now to configure the kernel suitable for the
> Bamboo hardware environment...

hmmm, for what platform have you configured the kernel?

> I suppose some of you did this before already so I want to ask if
> somebody is so kind and
> posts me the according .config file?
-- 
Gerhard Jaeger <gjaeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.pikeos.com
