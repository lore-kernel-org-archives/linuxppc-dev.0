Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3E50B67B60
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 06:05:53 +1000 (EST)
Date: Mon, 11 Sep 2006 15:05:49 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Perhaps git-update-server-info needs to be run on
	.../paulus/powerpc.git?
Message-Id: <20060911150549.0e08bbcd.kim.phillips@freescale.com>
In-Reply-To: <17669.7544.599959.442534@cargo.ozlabs.ibm.com>
References: <20060808193555.301bc229.kim.phillips@freescale.com>
	<17625.18896.977702.640753@cargo.ozlabs.ibm.com>
	<17669.7544.599959.442534@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Sep 2006 18:25:28 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Paul Mackerras writes:
> 
> > Kim Phillips writes:
> > 
> > > Linus' tree clones fine, paulus' doesn't:
> > 
> > Try now...
> > 
> > Paul.
> 
> Oops, mail system error, ignore me...
> 
> Paul.


funnily enough, I can't seem to clone your tree again today; I'm using the http: protocol.  

hopefully, the fix should only be a matter of:

chmod +x hooks/post-update

Thanks,

Kim
