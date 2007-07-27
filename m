Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id EA229DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 21:00:07 +1000 (EST)
Date: Fri, 27 Jul 2007 13:01:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ehca: remove checkpatch.pl's warnings "externs should
	be avoided in .c files"
Message-ID: <20070727110118.GB12647@uranus.ravnborg.org>
References: <200707271254.51055.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707271254.51055.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	general@lists.openfabrics.org, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2007 at 12:54:50PM +0200, Hoang-Nam Nguyen wrote:
> >From b5d0336089b5ebe5b18acb94b2c94c2026cb95ee Mon Sep 17 00:00:00 2001
> From: Hoang-Nam Nguyen <hnguyen at de.ibm.com>
> Date: Fri, 27 Jul 2007 10:24:49 +0200
> Subject: [PATCH] remove checkpatch.pl's warnings "externs should be avoided in .c files"
> 
> Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

And you checked that said .h file was indeed included by the .c file that has the original definition?
Otherwise the definition and the declaration can get out of sync without notice.

	Sam
