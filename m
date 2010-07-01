Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 846331007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 21:18:31 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o61BArsS031527
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jul 2010 05:10:53 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o61BIQlb118664
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jul 2010 05:18:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o61BIPej019698
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jul 2010 05:18:25 -0600
Date: Thu, 1 Jul 2010 07:18:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 14/27] KVM: PPC: Magic Page BookE support
Message-ID: <20100701111823.GE7756@zod.rchland.ibm.com>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-15-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277980982-12433-15-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 01, 2010 at 12:42:49PM +0200, Alexander Graf wrote:
>As we now have Book3s support for the magic page, we also need BookE to
>join in on the party.
>
>This patch implements generic magic page logic for BookE and specific
>TLB logic for e500. I didn't have any 440 around, so I didn't dare to
>blindly try and write up broken code.

Is this the only patch in the series that needs 440 specific code?  Also,
does 440 KVM still work after this series is applied even without the code
not present in this patch?

josh
