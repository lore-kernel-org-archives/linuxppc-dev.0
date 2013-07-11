Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 2884B2C030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:51:26 +1000 (EST)
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373546368.19894.87.camel@pasglop>
Date: Thu, 11 Jul 2013 14:51:20 +0200
Message-Id: <4133424D-B105-4CB1-A72A-4F47A6184DC7@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru> <51DC4228.7010607@suse.de>
 <51DCEA76.9070808@ozlabs.ru> <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de>
 <51DE3ECB.7080803@ozlabs.ru> <43E93931-F213-47CC-ADCF-D3A6D6BC4372@suse.de>
 <51DE8EE9.2000508@ozlabs.ru> <C6BC1E27-4C9C-4A18-A64A-052202DA64B5@suse.de>
 <1373546368.19894.87.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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


On 11.07.2013, at 14:39, Benjamin Herrenschmidt wrote:

> On Thu, 2013-07-11 at 13:15 +0200, Alexander Graf wrote:
>> And that's bad. Jeez, seriously. Don't argue this case. We enable new
>> features individually unless we're 100% sure we can keep everything
>> working. In this case an ENABLE_CAP doesn't hurt at all, because user
>> space still needs to handle the hypercalls if it wants them anyways.
>> But you get debugging for free for example.
>=20
> An ENABLE_CAP is utterly pointless. More bloat. But you seem to like
> it :-)

I don't like bloat usually. But Alexey even had an #ifdef DEBUG in there =
to selectively disable in-kernel handling of multi-TCE. Not calling =
ENABLE_CAP would give him exactly that without ugly #ifdefs in the =
kernel.


Alex

>=20
> Ben.
>=20
>=20
