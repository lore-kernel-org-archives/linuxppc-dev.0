Return-Path: <paulus@ozlabs.org>
Date: Thu, 12 Jan 2012 15:16:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 04/16] KVM: PPC: factor out lpid allocator from
 book3s_64_mmu_hv
Message-ID: <20120112041632.GA32487@drongo>
References: <20111221013420.GD8378@schlenkerla.am.freescale.net>
 <CE2DB77D-1D57-4D7A-92E6-08368733DE6F@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CE2DB77D-1D57-4D7A-92E6-08368733DE6F@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 KVM mailing list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 09, 2012 at 04:35:52PM +0100, Alexander Graf wrote:

> Paul, does this work for you? IIRC you need this code to be
> available from real mode, which powerpc.c isn't in, right?

We don't need to allocated LPIDs from real mode, so it should be OK.
book3s_64_mmu_hv.c is not real mode code, and it gets compiled into
the KVM module.

Paul.
