Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76D40B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 04:47:50 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <AANLkTiksUkrO8ryEiX3Yv-_2KGVE6r5RIT4YDvrmoDPL@mail.gmail.com>
Date: Fri, 2 Jul 2010 20:47:44 +0200
Message-Id: <3085B58A-01A1-4B5C-A0E7-024DCFDFD4B2@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<AANLkTiksUkrO8ryEiX3Yv-_2KGVE6r5RIT4YDvrmoDPL@mail.gmail.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2010, at 19:59, Hollis Blanchard wrote:

> [Resending...]
>=20
> Please reconcile this with
> http://www.linux-kvm.org/page/PowerPC_Hypercall_ABI, which has been
> discussed in the (admittedly closed) Power.org embedded hypervisor
> working group. Bear in mind that other hypervisors are already
> implementing the documented ABI, so if you have concerns, you should
> probably raise them with that audience...

We can not use sc with LV=3D1 because that would break the KVM in =
something else case which is KVM's strong point on PPC.

Alex
