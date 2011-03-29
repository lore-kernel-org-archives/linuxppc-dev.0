Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05372B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 20:37:50 +1100 (EST)
Subject: Re: [PATCH 3/4] KVM: PPC: e500: Introduce msr_block for e500v2
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110328192558.GB11104@schlenkerla.am.freescale.net>
Date: Tue, 29 Mar 2011 11:37:44 +0200
Message-Id: <76DF6B63-BCFC-4B8D-80A8-6C1578C6A22C@suse.de>
References: <20110328192558.GB11104@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.03.2011, at 21:25, Scott Wood wrote:

> From: yu liu <yu.liu@freescale.com>
>=20
> In order to use lazy SPE register save/restore, we need to
> know when the guest is using MSR[SPE].  In order to do that, we
> need to control the actual MSR[SPE] separately from the guest's
> notion of MSR[SPE].

Please make this generic for BookE. There's no reason to have FSL ifdefs =
in the code.


Alex
