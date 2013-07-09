Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 02DB32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 07:54:54 +1000 (EST)
Subject: Re: [PATCH 0/2] powerpc: allow kvm to use kerel debug framework
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <14504.1373343872@ale.ozlabs.ibm.com>
Date: Tue, 9 Jul 2013 23:54:44 +0200
Message-Id: <636D011A-6C50-4E74-B4B2-658EC4E53E9C@suse.de>
References: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
 <C4D71A1A-3D5B-4C9C-A26B-9EAFFD9D87C5@suse.de>
 <14504.1373343872@ale.ozlabs.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, Bharat Bhushan <bharat.bhushan@freescale.com>,
 Bharat Bhushan <r65777@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.07.2013, at 06:24, Michael Neuling wrote:

> Alexander Graf <agraf@suse.de> wrote:
>=20
>>=20
>> On 04.07.2013, at 08:15, Bharat Bhushan wrote:
>>=20
>>> From: Bharat Bhushan <bharat.bhushan@freescale.com>
>>>=20
>>> This patchset moves the debug registers in a structure, which allows
>>> kvm to use same structure for debug emulation.
>>>=20
>>> Note: Earilier a patchset =
"https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-June/108132.html"
>>> was sent which is a bunch of six patches. That patchset is divided =
into two parts:
>>> 	1) powerpc specific changes (These 2 patches are actually have =
those changes)
>>> 	2) KVM specific changes (will send separate patch on agraf =
repository)
>>=20
>> Mikey, if you like those could you please apply the into a topic
>> branch and get that one merged with Ben? I'd also pull it into my =
tree
>> then.
>=20
> benh would pull these directly. =20
>=20
> I'll have a chat with him to see if he wants my ACK before he does =
that.

I have a bunch of patches that I need to apply on top, so I need a topic =
branch.


Alex
