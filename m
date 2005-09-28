Return-Path: <andrewd.lists@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.194])
	by ozlabs.org (Postfix) with ESMTP id 7AA5A6841A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 09:33:40 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id i27so940902wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 16:33:39 -0700 (PDT)
Message-ID: <54823def050928162638991050@mail.gmail.com>
Date: Thu, 29 Sep 2005 09:26:21 +1000
From: Andrew Dennison <andrewd.lists@gmail.com>
To: "Derycke, Johan" <johan.derycke@barco.com>
In-Reply-To: <81A66F72DCACD511B0600002A551BFCB08D3A926@kuumex05.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <81A66F72DCACD511B0600002A551BFCB08D3A926@kuumex05.barco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 and pcmcia
Reply-To: Andrew Dennison <andrewd.lists@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/28/05, Derycke, Johan <johan.derycke@barco.com> wrote:
>
> I am working on a custom board based on the Lite5200.
> It is expanded with a PCI1410 PC Card Controller on the PCI bus.
>
> In the history of this list I found a patch against an older kernel versi=
on
> to solve some issues:
> http://ozlabs.org/pipermail/linuxppc-embedded/2004-December/016273.html
>
> I took the old 2.4.23 kernel and applied the patch.
> I could get my 3c589 network adaptor to work.

Nice to get some feedback, Your the second person that has used it.

> Is this patch available for the current 2.4.25 kernel?
>

It will work conceptually with 2.4.25 as I'm currently running a
relatively recent denx kernel with similar changes. I haven't
published a recent patch yet as there wasn't much feedback last
time...

I've recently done some more work on this to clean it up, for example
USB didn't work with that previous patch but they now coesist happily.

I'll look at posting a patch soon when it's merged into my shiny new GIT tr=
ee.

Andrew
