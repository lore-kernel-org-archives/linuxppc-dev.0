Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55DBD1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 19:53:24 +1000 (EST)
Message-ID: <537F1A8D.9000704@suse.de>
Date: Fri, 23 May 2014 11:53:17 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.05.14 10:15, Michael Neuling wrote:
> This patch series implements split core mode on POWER8.  This enables up to 4
> subcores per core which can each independently run guests (per guest SPRs like
> SDR1, LPIDR etc are replicated per subcore).  Lots more documentation on this
> feature in the code and commit messages.
>
> Most of this code is in the powernv platform but there's a couple of KVM
> specific patches too.
>
> Patch series authored by mpe and me with a few bug fixes from others.
>
> v2:
>    There are some minor updates based on comments and I've added the Acks by
>    Paulus and Alex for the KVM code.

I don't see changelogs inside the individual patches. Please make sure 
to always mention what changed from one version to the next in a 
particular patch, so that I have the chance to check whether that change 
was good :).

Also, is there any performance penalty associated with split core mode? 
If not, could we just always default to split-by-4 on POWER8 bare metal?


Alex
