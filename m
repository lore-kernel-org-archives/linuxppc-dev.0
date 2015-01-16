Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 348491A0D38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 23:12:30 +1100 (AEDT)
Message-ID: <54B90027.5040103@suse.de>
Date: Fri, 16 Jan 2015 13:12:23 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] current ACCESS_ONCE patch queue
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15.01.15 09:58, Christian Borntraeger wrote:
> Folks,
> 
> fyi, this is my current patch queue for the next merge window. It
> does contain a patch that will disallow ACCESS_ONCE on non-scalar
> types.
> 
> The tree is part of linux-next and can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next

KVM PPC bits are:

 Acked-by: Alexander Graf <agraf@suse.de>



Alex
