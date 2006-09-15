Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17674.32333.958250.868794@cargo.ozlabs.ibm.com>
Date: Fri, 15 Sep 2006 20:19:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
In-Reply-To: <20060908033508.GA5203@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<20060908033508.GA5203@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> Abstract the operations used in the bootwrapper.  The operations
> have been divided up into platform operations (platform_ops),
> device tree operations (dt_ops), and console operations (console_ops).

Is there any particular reason why the call_kernel() method is in the
dt_ops?  That doesn't seem like a very natural place for it.  Is it
just so the dt_ops can say whether to pass NULL or the prom entry
point in r5?

Paul.
