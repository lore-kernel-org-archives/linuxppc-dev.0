Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jemzi8umx2.fsf@sykes.suse.de>
References: <1136593470.4840.154.camel@localhost.localdomain>
	<jemzi8umx2.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 09:09:01 +1100
Message-Id: <1136671741.30123.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] 0/5 powerpc: Platform & i2c updates & cpufreq
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-07 at 15:34 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This serie of patch replaces the 2 I posted recently for platform
> > functions & g5 cpufreq. It's not a 100% finished job yet but it's
> > getting closer.
> 
> The patch appears to break ALSA on PowerMac Dual 1.8GHz.  The volume
> control is going wild, and I'm getting distorted sound.

Ok, I think it's the sound driver's i2c code relied on a bug in
i2c-keywest that has been fixed by the new i2c driver.

I'll post a fix later today.

Ben.
