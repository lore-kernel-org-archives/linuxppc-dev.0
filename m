Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id ABF08DDED5
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:15:55 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so281695yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 09:15:53 -0700 (PDT)
Date: Mon, 30 Jun 2008 10:15:50 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/bootwrapper: Add documentation of boot
	wrapper targets
Message-ID: <20080630161550.GC17916@secretlab.ca>
References: <20080628050407.6067.90225.stgit@trillian.secretlab.ca>
	<18536.26913.342478.867665@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18536.26913.342478.867665@cargo.ozlabs.ibm.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 03:03:29PM +1000, Paul Mackerras wrote:
> Grant Likely writes:
> > +simpleboot-*)
> > +    platformo="$object/simpleboot.o"
> > +    binary=y
> > +    ;;
> >  esac
> 
> Evidently your patch does more than just "Add documentation"...

Ugh.

While writing the documentation, I noticed that part of the simpleboot
target was missing.  I fixed it and made a mental note to either split
it off into a separate patch or document the change better...

Apparently my mental notes need tuning.

Sorry, I'll split it off and repost.

Cheers,
g.
