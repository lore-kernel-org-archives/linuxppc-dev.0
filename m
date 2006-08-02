Return-Path: <trini@kernel.crashing.org>
Date: Wed, 2 Aug 2006 09:19:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 5/6] bootwrapper: Add support for the DINK firmware
Message-ID: <20060802161934.GI3075@smtp.west.cox.net>
References: <20060719231421.GF3887@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719231421.GF3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 04:14:21PM -0700, Mark A. Greer wrote:

> This patch adds the firmware operations that support the DINK firmware
> from Freescale.

This isn't really DINK support (which would mean actually talking
back/with DINK, parsing the infos that it does pass along, and it does,
iirc, but I don't recall if it's at all ever correct / useful :)) but
just a, um, I suck at naming things (see arch/ppc/boot/simple) but
non-nonsense, no help 'firmware' ops.  Please think up a name that
doesn't suck (as a name I would come up with would).  Thanks!

-- 
Tom Rini
