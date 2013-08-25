Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 3E1B22C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 04:13:28 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1377232085.3613.0.camel@pasglop>
Date: Sun, 25 Aug 2013 19:09:32 +0100
Message-Id: <D8DA9E06-8EAA-4494-81B7-4DB37C9735F5@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com> <1377232085.3613.0.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.08.2013, at 05:28, Benjamin Herrenschmidt wrote:

> On Fri, 2013-08-23 at 09:01 +0530, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>>=20
>>> On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
>>>=20
>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>=20
>>> Isn't this you?
>>=20
>> Yes. The patches are generated using git format-patch and sent by
>> git send-email. That's how it always created patches for me. I am not =
sure if
>> there is a config I can change to avoid having From:
>=20
> Don't bother, that's perfectly fine, and git am will do the right =
thing.

It will, but it's an indicator that something in his git config is =
misconfigured. Usually when git sees "Author =3D=3D Sender" it will omit =
the From: line.


Alex
