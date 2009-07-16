Return-Path: <slightlyunconventional@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B203BB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 03:31:53 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 02BB6DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 03:31:52 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so106909qwd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 10:31:50 -0700 (PDT)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <73afa9bf0907160532l5525124cg72bee2631e3dab66@mail.gmail.com>
References: <73afa9bf0907160532l5525124cg72bee2631e3dab66@mail.gmail.com>
Date: Thu, 16 Jul 2009 10:25:40 -0700
Message-ID: <fb412d760907161025k367becf7vaba5ba54756968f7@mail.gmail.com>
Subject: Re: riscwatch shows up core status UNKNOWN for 970mp ppc processor
From: Hollis Blanchard <hollis@penguinppc.org>
To: anil kumar <anildahiya80@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 16, 2009 at 5:32 AM, anil kumar<anildahiya80@gmail.com> wrote:
> Hello
> I am newbie to RISCWatch and debugging using JTAG interface .I want to de=
bug
> Linux Kernel on target board
> using jtag interface provided on board.
>
> To=A0 debug 970MP dual core ppc processor on traget board, I installed
> RISCWatch software on my window host.
>
> My Setup:
> ----------
> =A0=A0 Host <--(over ethernet)--> RISCWatch 13H6423 <--(jtag interface)--=
> 970MP
> Processor
>
> I am able to detect two core on target 970MP processor but it shows both
> cores as `UNKNOWN` . I have no idea,
> why riscwatch shows up status of both cores as UNKNOWN?

You should probably contact ppcsupp@us.ibm.com instead of this mailing list=
.

-Hollis
