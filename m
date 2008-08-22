Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id BFC54DF29C
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 02:13:44 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so95864anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:13:43 -0700 (PDT)
Date: Fri, 22 Aug 2008 12:13:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yoder Stuart <stuart.yoder@freescale.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-ID: <20080822161316.GB22903@yoda.jdub.homelinux.org>
References: <48AE4093.8050504@firmworks.com>
	<fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com>
	<48AE4C4A.8040804@firmworks.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA304461060@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA304461060@az33exm25.fsl.freescale.net>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	WOOD SCOTT <scottwood@freescale.com>, sparclinux@vger.kernel.org,
	Mitch Bradley <wmb@firmworks.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 09:00:09AM -0700, Yoder Stuart wrote:
>There are a few bindings specified in the ePAPR, based on the old
>Open Firmware working group stuff:
>   -cpu
>   -interrupt controllers
>   -PCI
>   -network devices
>   -DCR devices

Er, I don't think that one is based on the old workgroup.  DCR is only
applicable to PowerPC 4xx devices, and those have never had open firmware.

>The best way to publish bindings will be on the web.  I've been
>looking into getting power.org to host a wiki-based site
>that could be used as a repository for bindings.  We could have
>both an area for general bindings and company specific ones.
>I've made some progress here and actually have a sandbox wiki
>that I'm playing with.

That sounds good, but I have one suggestion.  Use the wiki for
submission and discussion of new binding proposals, but once they
are agreed upon put them in a static webpage somewhere until they
are incorporated into the next ePAPR revision.  Wikis are awesome
for changing stuff, but you don't want people to go back and change
a binding that has already been approved (for whatever definition
of approved we come up with.)

Also, you might want to have some kind of Licensing or copyright
assignment for all wiki contributions.  Talk to your legal team or
the power.org legal team about that if you haven't already.

josh
