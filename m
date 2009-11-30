Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 0DF7EB7082
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 00:15:42 +1100 (EST)
Message-ID: <4B13C576.5020405@redhat.com>
Date: Mon, 30 Nov 2009 15:15:34 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259586122-19155-1-git-send-email-agraf@suse.de>
In-Reply-To: <1259586122-19155-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/2009 03:02 PM, Alexander Graf wrote:
> Currently userspace has no chance to find out which virtual address space we're
> in and resolve addresses. While that is a big problem for migration, it's also
> unpleasent when debugging, as gdb and the monitor don't work on virtual
> addresses.
>
> This patch exports enough of the MMU segment state to userspace to make
> debugging work and thus also includes the groundwork for migration.
>    

Looks good.  Ben, please carry this in your tree.

-- 
error compiling committee.c: too many arguments to function
