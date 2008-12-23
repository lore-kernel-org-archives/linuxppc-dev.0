Return-Path: <parabelboi@bopserverein.de>
Received: from mail.bopserverein.de (unknown [80.190.146.56])
	by ozlabs.org (Postfix) with ESMTP id B73C0DDDE3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 03:29:36 +1100 (EST)
Received: from localhost (unknown [10.88.0.94])
	by mail.bopserverein.de (Postfix) with ESMTP id 56D28DC49
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 17:22:30 +0100 (CET)
Date: Tue, 23 Dec 2008 17:22:45 +0100
From: Christian Krafft <parabelboi@bopserverein.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: schizophrenic G5 ...
Message-ID: <20081223172245.792a9e2b@bopserverein.de>
In-Reply-To: <494EDB3F.4090604@hypersurf.com>
References: <494EDB3F.4090604@hypersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 21 Dec 2008 16:11:43 -0800
Kevin Diggs <kevdig@hypersurf.com> wrote:

> Hi,
> 
> 	I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has
> YDL 6.0 on it. Using the stock YDL 2.6.23 kernel this machine
> "appears" to work fine.
> 
> 	After finally getting it to boot under 2.6.27, it will shut
> itself off if put under any significant load. And it is doing it very
> quickly. Like within a few seconds of becoming busy. I just
> discovered it is spitting out messages about "temperature way above
> maximum" (from therm_pm72.c).
> 

I have a very similar problem on my mac at work.
I don't know atm how to look up the critical temperature that is
fused. My mac reported only 55 degrees for the one cpu.
The critical temperature can be read from the device-tree if i remember
it correctly.
I heard that there exists a bootable CD which contains a tool to refuse
the CPU. Dont know where to download it, so my pragmatic solution was to
relocate the machine to a room with air conditioning ;-)
And I also run the ONE cpu at lowest frequency.

ck

-- 
Hi, I am a signature virus. Please copy me into your ~/.signature to
help me spread.
