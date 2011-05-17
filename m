Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 051F8B6EF3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 21:38:24 +1000 (EST)
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
	<20110517111536.GC7924@brick.ozlabs.ibm.com>
In-Reply-To: <20110517111536.GC7924@brick.ozlabs.ibm.com>
Mime-Version: 1.0 (iPad Mail 8H7)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <14CFAA70-1747-4902-8CC1-4BE924CAD031@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/13] Hypervisor-mode KVM on POWER7
Date: Tue, 17 May 2011 13:38:57 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 17.05.2011 um 13:15 schrieb Paul Mackerras <paulus@samba.org>:

> On Tue, May 17, 2011 at 11:46:34AM +0200, Alexander Graf wrote:
>=20
>> Very nice patches indeed :). Is there any way I can test them? I
>> don't like pulling code that I couldn't run anywhere yet.
>=20
> I can understand that, but unfortunately there are no machines
> available outside of IBM at this stage that can run this stuff.
>=20
> Do you think that the earlier patches in the series could go in for
> 2.6.40?  Patches 1 to 8 don't require hypervisor mode and can be
> tested on a G5 or whatever.

Oh, I can and will certainly test if the code breaks pr mode, but that doesn=
't mean it will do the right thing on HV machines :o.

>=20
> What would be the path for these patches to get upstream?  Would this
> stuff normally go through Avi's tree?  There is a bit of a
> complication in that they are based on Ben's next branch.  Would Avi
> pull Ben's next branch, or would they go in via Ben's tree?

Usually the ppc tree gets merged into Avi's tree and goes on from there. Whe=
n we have interdependencies, we can certainly do it differently though. We c=
an also shove them through Ben's tree this time around, as there are more de=
pendencies on ppc code than KVM code.

>=20
> Thanks,
> Paul.
