Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:34:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Message-ID: <20070328013436.GB7097@mag.az.mvista.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
	<4609BF47.6030306@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4609BF47.6030306@am.sony.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2007 at 06:05:11PM -0700, Geoff Levand wrote:
> Mark A. Greer wrote:
> > Disable external interrupts very early in the bootwrapper in case
> > the firmware left a device generating interrupts.
> 
> This is just a guess at what is happening, but I think the OF on my
> G5 uses the timer interrupt as a kind of watchdog timer, so that if
> the loaded code hangs, OF will regain control.  If you disable
> interrupts, you may loose this functionality.

Ah, okay.
