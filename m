Return-Path: <mgreer@mvista.com>
Date: Fri, 15 Sep 2006 11:01:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060915180129.GE1884@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<20060908033508.GA5203@mag.az.mvista.com>
	<17674.32333.958250.868794@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17674.32333.958250.868794@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2006 at 08:19:57PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Abstract the operations used in the bootwrapper.  The operations
> > have been divided up into platform operations (platform_ops),
> > device tree operations (dt_ops), and console operations (console_ops).
> 
> Is there any particular reason why the call_kernel() method is in the
> dt_ops?  That doesn't seem like a very natural place for it.

No, it doesn't seem natural.

> Is it
> just so the dt_ops can say whether to pass NULL or the prom entry
> point in r5?

Yes.  Whether you pass the NULL or not hinges on whether its flat tree
or not so I made it a dt_op.  What are you thinking?

Mark
