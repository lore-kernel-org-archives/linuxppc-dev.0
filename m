Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 37BC32C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 19:14:49 +1100 (EST)
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
 <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
 <1383767930.4776.125.camel@pasglop>
 <92DFDE0F-0E72-41F9-9562-3EC0CA5BD2B1@suse.de>
 <1383810909.4776.171.camel@pasglop>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1383810909.4776.171.camel@pasglop>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <D41E9B02-613E-498D-B68B-18FCAC21637F@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
Date: Thu, 7 Nov 2013 09:14:46 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Liu Ping Fan <kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 07.11.2013 um 08:55 schrieb Benjamin Herrenschmidt <benh@kernel.crashing.=
org>:

> On Thu, 2013-11-07 at 08:52 +0100, Alexander Graf wrote:
>> Am 06.11.2013 um 20:58 schrieb Benjamin Herrenschmidt <benh@kernel.crashi=
ng.org>:
>>=20
>>> On Wed, 2013-11-06 at 12:24 +0100, Alexander Graf wrote:
>>>> On 05.11.2013, at 08:42, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>>>=20
>>>>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>>>>=20
>>>> Patch description missing.
>>>=20
>>> Do you really need a description for trivial one-lines whose subject
>>> is a perfectly complete description already ?
>>=20
>> Would I ask for it otherwise? It's also not 100% obvious that the assignm=
ent is redundant.
>=20
> And ? An explanation isn't going to be clearer than the code in that
> case ...

It's pretty non-obvious when you do a git show on that patch in 1 year from n=
ow, as the redundancy is out of scope of what the diff shows.


Alex
