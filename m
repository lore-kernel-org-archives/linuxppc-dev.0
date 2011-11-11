Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1E40B1007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2011 03:03:07 +1100 (EST)
Message-ID: <4EBD474A.3010700@suse.de>
Date: Fri, 11 Nov 2011 17:03:22 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] KVM: PPC: move compute_tlbie_rb to book3s_64 common header
References: <1312907508-14599-1-git-send-email-agraf@suse.de>	<1312907508-14599-2-git-send-email-agraf@suse.de>
 <m2bosmpmmz.fsf_-_@igel.home>
In-Reply-To: <m2bosmpmmz.fsf_-_@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 06:08 PM, Andreas Schwab wrote:
> compute_tlbie_rb is only used on ppc64 and cannot be compiled on ppc32.
>
> Signed-off-by: Andreas Schwab<schwab@linux-m68k.org>

Thanks, applied to kvm-ppc-next.

Alex
