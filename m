Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B6F40B7B95
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 05:51:33 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/6 v5] Memory DLPAR Handling
References: <4AE8ADCF.6090104@austin.ibm.com> <4AE8B02C.3060706@austin.ibm.com>
Date: Thu, 05 Nov 2009 10:51:27 -0800
In-Reply-To: <4AE8B02C.3060706@austin.ibm.com> (Nathan Fontenot's message of
	"Wed, 28 Oct 2009 15:57:16 -0500")
Message-ID: <adapr7wbya8.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This isn't a review of this patch -- more a question out of curiousity
about how you actually can do memory remove in practice.  Do you have
any coordination between the platform/hypervisor and the kernel to make
sure that a memory region you might want to remove later gets put into
zone_movable so that there's a chance for the kernel to vacate it?  Or
do you have some other way to coordinate or at least expose which
regions of memory the kernel will have a chance at releasing?

Thanks,
  Roland
