Return-Path: <olof@lixom.net>
Date: Tue, 26 Feb 2008 08:16:24 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/6] pasemi_mac updates for 2.6.26
Message-ID: <20080226141624.GB22572@lixom.net>
References: <20080221025753.903665000@lixom.net>
	<18371.57542.77446.443231@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18371.57542.77446.443231@cargo.ozlabs.ibm.com>
Cc: netdev@vger.kernel.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2008 at 08:49:58PM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Here's a set of updates for pasemi_mac for 2.6.26. Some of them touch
> > the dma_lib in the platform code as well, but it's easier if it's all
> > merged through netdev to avoid dependencies.
> > 
> > Major highlights are jumbo frame support and ethtool basics, the rest
> > is mostly minor plumbing around it.
> 
> What route do you think these should take upstream?  I'm happy to take
> them if Jeff is OK with that.

I've sent them through Jeff in the past, that's been convenient when
there's been churn in the network APIs. I'm not sure if there's much of
that for .26 though.

If Jeff prefers to ACK, I'll just add it to my git and ask you to pull
that. But I was originally planning to just feed it through him.

(Note: I'll repost the patch set later today or tomorrow with a couple
of tweaks).


-Olof
