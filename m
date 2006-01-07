Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1136593470.4840.154.camel@localhost.localdomain>
Date: Sat, 07 Jan 2006 15:34:33 +0100
In-Reply-To: <1136593470.4840.154.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Sat, 07 Jan 2006 11:24:30 +1100")
Message-ID: <jemzi8umx2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This serie of patch replaces the 2 I posted recently for platform
> functions & g5 cpufreq. It's not a 100% finished job yet but it's
> getting closer.

The patch appears to break ALSA on PowerMac Dual 1.8GHz.  The volume
control is going wild, and I'm getting distorted sound.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
