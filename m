Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17982.43385.49199.628627@cargo.ozlabs.ibm.com>
Date: Mon, 7 May 2007 14:22:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/7] Add support for 750CL Holly board
In-Reply-To: <1178381871.3393.32.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178381871.3393.32.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> +config HOLLY

That's a bit too non-specific, I think; please make it PPC_HOLLY.

Paul.
