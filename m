Return-Path: <jacmet@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 5B98CB70E1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 17:01:04 +1000 (EST)
Received: by wwb18 with SMTP id 18so3109173wwb.21
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 00:01:00 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
References: <1281331211-17878-1-git-send-email-agust@denx.de>
	<1281333528-20694-1-git-send-email-agust@denx.de>
Date: Fri, 20 Aug 2010 09:00:56 +0200
In-Reply-To: <1281333528-20694-1-git-send-email-agust@denx.de> (Anatolij
	Gustschin's message of "Mon, 9 Aug 2010 07:58:48 +0200")
Message-ID: <87aaohpy3b.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Anatolij" == Anatolij Gustschin <agust@denx.de> writes:

 Anatolij> The GPIO controller of MPC512x is slightly different from
 Anatolij> 8xxx GPIO controllers. The register interface is the same
 Anatolij> except the external interrupt control register. The MPC512x
 Anatolij> GPIO controller differentiates between four interrupt event
 Anatolij> types and therefore provides two interrupt control registers,
 Anatolij> GPICR1 and GPICR2. GPIO[0:15] interrupt event types are
 Anatolij> configured in GPICR1 register, GPIO[16:31] - in GPICR2 register.

 Anatolij> This patch adds MPC512x speciffic set_type() callback and
 Anatolij> updates config file and comments. Additionally the gpio chip
 Anatolij> registration function is changed to use for_each_matching_node()
 Anatolij> preventing multiple registration if a node claimes compatibility
 Anatolij> with another gpio controller type.

 Anatolij> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Sorry, was away on holiday.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
