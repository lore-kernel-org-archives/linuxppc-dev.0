Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/6] Implement split core for POWER8
In-reply-to: <1398303165-6576-1-git-send-email-mikey@neuling.org>
References: <1398303165-6576-1-git-send-email-mikey@neuling.org>
Date: Wed, 30 Apr 2014 15:09:37 +1000
Message-ID: <9524.1398834577@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This patch series implements split core mode on POWER8.  This enables up to 4
> subcores per core which can each independently run guests (per guest SPRs like
> SDR1, LPIDR etc are replicated per subcore).  Lots more documentation on this
> feature in the code and commit messages.
> 
> Most of this code is in the powernv platform but there's a couple of KVM
> specific patches too.
> 
> Alex: If you're happy with the KVM patches, please ACK them and benh can hold
> this series.

Alex,

Any chance we can get an ACK on these two KVM patches so benh can put
this series in his next branch?

Mikey
