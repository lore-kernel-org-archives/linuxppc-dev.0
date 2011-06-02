Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F554B6F86
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2011 05:22:03 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p52J9JYf011439
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jun 2011 13:09:19 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p52JLhQQ190144
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jun 2011 13:21:43 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p52JLaFJ018316
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jun 2011 13:21:39 -0600
Date: Thu, 2 Jun 2011 15:22:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO
	not set
Message-ID: <20110602192253.GB2457@zod.rchland.ibm.com>
References: <1307031956-11686-1-git-send-email-galak@kernel.crashing.org>
	<BANLkTinQxjxefrCC0HDVGChzAKXoTBch7g@mail.gmail.com>
	<BANLkTikyOf5xYHy1pCbcg06BkyST4QNyXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikyOf5xYHy1pCbcg06BkyST4QNyXA@mail.gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2011 at 07:11:18PM +0000, Tabi Timur-B04825 wrote:
>On Thu, Jun 2, 2011 at 12:32 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>> Should be Reported-by Timur, right?
>
>Technically, yes.  For the record, I don't care about these things.
>It implies that only willing to report the problem, but too lazy to
>fix it; which is true, but I'd hate to see that fact permanently
>etched in the git history. :-)

So for you, that might hold true.  (You said it, not me.)  But for some,
they can report compile errors but might not have the technical ability
to fix it.  They're still learning, or they are using randconfig and
don't understand the arch/interaction, etc.  The tag has value.

josh
