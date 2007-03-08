Return-Path: <linas@austin.ibm.com>
Date: Thu, 8 Mar 2007 17:29:42 -0600
To: Felix Domke <tmbinc@elitedvb.net>
Subject: Re: [patch 6/7] xenon: add SMC support
Message-ID: <20070308232942.GF30703@austin.ibm.com>
References: <20070307180144.812594000@elitedvb.net>>
	<20070307180526.334384000@elitedvb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070307180526.334384000@elitedvb.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 07:01:50PM +0100, Felix Domke wrote:
> This adds lowlevel support for the "System Management Controller"
> on the Xenon southbridge, which controls power, the frontpanel leds, 
> infrared remote, tilt switch, AVIP detection, RTC and DVD tray control.

Unlike Arndt, I'd suggest that these three lines appear in the C file
as well. I've spent too many days wondering what some some file was 
supposed to be doing, because the author didn't even bother to mention
something as basic as this. This is particularly important when 
documentation is not generally available.

--linas
