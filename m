Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <433C7882.20000@am.sony.com>
Date: Thu, 29 Sep 2005 16:28:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1127978432.6102.53.camel@gaston>
In-Reply-To: <1127978432.6102.53.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc64-dev@ozlabs.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: iMac G5: experimental thermal & cpufreq support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> The algorithm itself is extracted from darwin. However, it's a rather
> complex modified version of the PID algorithm, and thus it could use
> some review to make sure I got everything right.
> 

As we are already in the digital domain, I would think it would be 
more savvy to use a digital controller than try to simulate an
analog controller...  Why don't you abstract the control algorithm 
such that you can plug in others as they are developed.

-Geoff
