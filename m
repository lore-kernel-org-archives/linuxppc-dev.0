Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 86A20DE0D2
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:42:44 +1100 (EST)
From: Jarod Wilson <jwilson@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] firewire: endianess fix
Date: Thu, 28 Feb 2008 13:42:05 -0500
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
In-Reply-To: <1204179959.15052.372.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802281342.06493.jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 February 2008 01:25:59 am Benjamin Herrenschmidt wrote:
> > Under Mac OS X, system.log says "FireWire (OHCI) Apple ID 31 built-in now
> > active". Could still be lucent though, judging by the subsys device ID of
> > 5811, which matches up w/the Lucent/Agere FW323. But no, apparently I
> > don't have the interesting one.
>
> Well, it's interesting in the sense that it's a "normal" OHCI then on a
> BE machine :-) My Pismo, which had the weirdo one, unfortunately died a
> while ago. I'll see if I can find another machine with that one in.

Ah, the pismo has it, eh? I think I may actually know of someone in the office 
that still has one of those that I might be able to borrow and poke at...


-- 
Jarod Wilson
jwilson@redhat.com
