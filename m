Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 0B767DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 14:44:23 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so133143wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 21:44:22 -0700 (PDT)
Date: Thu, 17 Jul 2008 22:44:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080718044420.GB9795@secretlab.ca>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
	<20080717110730.GA24775@polina.dev.rtsoft.ru>
	<20080717150715.GD31932@secretlab.ca>
	<20080718033512.GC18748@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080718033512.GC18748@yookeroo.seuss>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 18, 2008 at 01:35:12PM +1000, David Gibson wrote:
> This brings us back to the issue we also have with DCR controlled
> devices.  Possibly we should have two ways of representing these
> connections: for "pure" GPIO-only or DCR-only devices, they appear
> under the relevant controller with the addresses encoded with 'reg'.
> For devices on other busses which also have a few GPIO lines / DCR
> registers, they would appear on the other bus with 'gpios' or
> 'dcr-reg' properties (or some new, generalized 'other-bus-reg'
> property).

On the other hand; it's just LEDs.  I think a single scheme is enough.

:-)

g.
