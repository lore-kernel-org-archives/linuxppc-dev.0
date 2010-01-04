Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id 5889EB7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jan 2010 19:21:15 +1100 (EST)
Received: by ewy21 with SMTP id 21so7152691ewy.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Jan 2010 00:21:12 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH-V2] mpc8xxx_gpio: add interrupt support
References: <1261398375-32545-1-git-send-email-jacmet@sunsite.dk>
Date: Mon, 04 Jan 2010 09:20:41 +0100
In-Reply-To: <1261398375-32545-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Mon, 21 Dec 2009 13:26:15 +0100")
Message-ID: <878wcep9gm.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Comments?

With the added documentation I believe it's ready to go..

 Peter> ---
 Peter>  .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   22 +++-
 Peter>  arch/powerpc/sysdev/mpc8xxx_gpio.c                 |  147 ++++++++++++++++++++
 Peter>  2 files changed, 168 insertions(+), 1 deletions(-)

-- 
Bye, Peter Korsgaard
