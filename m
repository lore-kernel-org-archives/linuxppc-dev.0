Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18454.44114.425038.8901@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 15:04:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
In-Reply-To: <18454.42926.213374.977098@cargo.ozlabs.ibm.com>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
	<18454.42926.213374.977098@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> +7:	rlwinm	r12,r12,0,~TLF_SLEEPING

That should be rlwinm r12,r12,0,~_TLF_SLEEPING (with the leading
underscore), of course.  Thanks to Stephen Rothwell for pointing that
out.

Paul.
