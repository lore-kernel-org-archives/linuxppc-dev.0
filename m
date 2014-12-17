Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED0A1A0539
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 23:13:53 +1100 (AEDT)
Message-ID: <5491737A.5050106@suse.de>
Date: Wed, 17 Dec 2014 13:13:46 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Gleb Natapov <gleb@kernel.org>
Subject: Re: [PATCH] arch: powerpc: kvm: book3s_paired_singles.c:  Remove
 unused function
References: <1417991354-19932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1417991354-19932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07.12.14 23:29, Rickard Strandqvist wrote:
> Remove the function inst_set_field() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Thanks, applied all unused function patches in KVM PPC code to
kvm-ppc-queue.


Alex
