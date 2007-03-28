Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4609BF47.6030306@am.sony.com>
Date: Tue, 27 Mar 2007 18:05:11 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
References: <20070327222840.GA1266@mag.az.mvista.com>
In-Reply-To: <20070327222840.GA1266@mag.az.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> Disable external interrupts very early in the bootwrapper in case
> the firmware left a device generating interrupts.

This is just a guess at what is happening, but I think the OF on my
G5 uses the timer interrupt as a kind of watchdog timer, so that if
the loaded code hangs, OF will regain control.  If you disable
interrupts, you may loose this functionality.

-Geoff
