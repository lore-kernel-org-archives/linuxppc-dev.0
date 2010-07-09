Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15894B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 16:33:34 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <AANLkTilp94NW1GMMew3oI-4czkUEA5W-CFqN9UVs8xcZ@mail.gmail.com>
Date: Fri, 9 Jul 2010 08:33:27 +0200
Message-Id: <26BA2EE0-80E8-4C1D-ADDB-B65229AAFF23@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<AANLkTilp94NW1GMMew3oI-4czkUEA5W-CFqN9UVs8xcZ@mail.gmail.com>
To: MJ embd <mj.embd@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.07.2010, at 06:57, MJ embd wrote:

> On Thu, Jul 1, 2010 at 4:12 PM, Alexander Graf <agraf@suse.de> wrote:
>> On PPC we run PR=3D0 (kernel mode) code in PR=3D1 (user mode) and =
don't use the
>> hypervisor extensions.
>>=20
>> While that is all great to show that virtualization is possible, =
there are
>> quite some cases where the emulation overhead of privileged =
instructions is
>> killing performance.
>>=20
>> This patchset tackles exactly that issue. It introduces a paravirtual =
framework
>> using which KVM and Linux share a page to exchange register state =
with. That
>=20
> KVM and Linux or KVM and GuestOS ?

KVM and GuestOS. The first user is of course Linux.

Alex
