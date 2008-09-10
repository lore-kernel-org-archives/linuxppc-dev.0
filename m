Return-Path: <kim.phillips@freescale.com>
Date: Wed, 10 Sep 2008 09:26:31 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: TQM8349 and ARCH = powerpc
Message-Id: <20080910092631.07d5c1cc.kim.phillips@freescale.com>
In-Reply-To: <48C7D5C6.1070507@sympatec.com>
References: <48C68763.6030606@sympatec.com>
	<20080909112253.c9c9617f.kim.phillips@freescale.com>
	<48C7D5C6.1070507@sympatec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Sep 2008 16:12:22 +0200
Oliver Rutsch <orutsch@sympatec.com> wrote:

>    model = "tqc,tqm834x";
>    compatible = "tqc,tqm834x";

you need a arch/powerpc/platforms/83xx/tqm834x.c file that matches this.

Kim
