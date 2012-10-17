Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0ACBC2C00AC
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2012 17:25:57 +1100 (EST)
Subject: Re: [PATCH] kvm/powerpc: Handle errors in secondary thread grabbing
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1350416012.4678.54.camel@pasglop>
Date: Wed, 17 Oct 2012 08:25:48 +0200
Message-Id: <DE13C878-5E14-46A0-BB63-D32D7A24E001@suse.de>
References: <1350346550-32539-1-git-send-email-michael@ellerman.id.au>
 <20121016031352.GK1218@drongo> <1350367235.32704.1.camel@concordia>
 <1350416012.4678.54.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16.10.2012, at 21:33, Benjamin Herrenschmidt wrote:

> On Tue, 2012-10-16 at 17:00 +1100, Michael Ellerman wrote:
>>> Thanks for looking at this - but in fact this is fixed by my patch
>>> entitled "KVM: PPC: Book3S HV: Fix some races in starting secondary
>>> threads" submitted back on August 28.
>>=20
>> OK thanks. It seems that patch didn't make 3.7 ?
>>=20
>> I don't see it in kvm-ppc-next either.
>=20
> Alex, WTF ?

Hrm. Not sure what happened there. I think I waited for your ack, but =
never actually applied things when it came. My bad :)


Alex
