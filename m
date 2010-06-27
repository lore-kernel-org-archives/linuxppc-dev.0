Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DBA1B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 08:03:11 +1000 (EST)
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <CF78C6B8-F600-4781-82CA-27865F745A60@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
	<4C2709F4.10805@redhat.com>
	<77DBE095-884F-4986-BE2B-15B2EEAD8CAC@suse.de>
	<4C271F5A.1030409@redhat.com>
	<DFC77851-3BE7-4746-93DE-287D5E27EF7D@suse.de>
	<4C272F08.8090709@redhat.com>
	<C90A3ABA-60E4-48D4-8332-3B49F3554447@suse.de>
	<4C273BAD.2090305@redhat.com>
	<CF78C6B8-F600-4781-82CA-27865F745A60@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Jun 2010 08:03:03 +1000
Message-ID: <1277676183.4200.131.camel@pasglop>
Mime-Version: 1.0
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avi Kivity <avi@redhat.com>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-06-27 at 14:06 +0200, Alexander Graf wrote:
> > Right, I was agreeing with you.  I meant there was no inc/dec mem  
> > insns.
> 
> Ah, I see :). I think that's really the only point where I deem the  
> x86 isa superior :). 

Heh, well, that's a typical RISC thing tho. I think ARM and MIPS are
like PowerPC here at least :-)

Cheers,
Ben.
