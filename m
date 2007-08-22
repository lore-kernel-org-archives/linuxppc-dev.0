Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18124.1417.743332.974941@cargo.ozlabs.ibm.com>
Date: Wed, 22 Aug 2007 19:44:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Subject: Re: [PATCH] ppc: remove unused amiga_request_irq and mach_request_irq
In-Reply-To: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
References: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fernando Luis V=E1zquez Cao writes:

> amiga=5Frequest=5Firq and mach=5Frequest=5Firq are never used, so del=
ete them.

OK, but is there a particular reason you want to do this=3F

The whole of arch/ppc is going away eventually, so I don't think we
need to remove it piece by piece.

Paul.
