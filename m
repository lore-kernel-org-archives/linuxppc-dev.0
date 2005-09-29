Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org
In-Reply-To: <1127978432.6102.53.camel@gaston>
References: <1127978432.6102.53.camel@gaston>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 18:40:29 +1000
Message-Id: <1127983229.6102.60.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iMac G5: experimental thermal & cpufreq support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-09-29 at 17:20 +1000, Benjamin Herrenschmidt wrote:

> http://gate.crashing.org/~benh/ppc64-smu-thermal-control.diff

You may want to re-download this one if you got it already, I just fixed
a bug in the calculations of the CPU control loop. It's now getting
results much more consistant with OS X. I still have to add some
overtemp handling and I'll remove the debug stuff and work on supporting
the PowerMac9,1 desktop model.

Ben.
