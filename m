Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 03C752C0308
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:58:09 +1000 (EST)
Message-ID: <1373547480.19894.102.camel@pasglop>
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 11 Jul 2013 22:58:00 +1000
In-Reply-To: <4133424D-B105-4CB1-A72A-4F47A6184DC7@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru>
 <51DC4228.7010607@suse.de> <51DCEA76.9070808@ozlabs.ru>
 <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de> <51DE3ECB.7080803@ozlabs.ru>
 <43E93931-F213-47CC-ADCF-D3A6D6BC4372@suse.de> <51DE8EE9.2000508@ozlabs.ru>
 <C6BC1E27-4C9C-4A18-A64A-052202DA64B5@suse.de>
 <1373546368.19894.87.camel@pasglop>
 <4133424D-B105-4CB1-A72A-4F47A6184DC7@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 14:51 +0200, Alexander Graf wrote:
> I don't like bloat usually. But Alexey even had an #ifdef DEBUG in
> there to selectively disable in-kernel handling of multi-TCE. Not
> calling ENABLE_CAP would give him exactly that without ugly #ifdefs in
> the kernel.

I don't see much point in disabling it... but ok, if that's a valuable
feature, then shoot some VM level ENABLE_CAP (please don't iterate all
VCPUs, that's gross).

Ben.
