Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BF60B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 07:47:29 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: fix build errors with older toolchains
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1313002585.1674.13.camel@pasglop>
Date: Wed, 10 Aug 2011 23:46:56 +0200
Message-Id: <329D535D-4A7C-4EE8-9342-EFE2D0EEBE81@suse.de>
References: <1312397755-15737-1-git-send-email-nacc@us.ibm.com>
	<4E429CAD.5050000@suse.de> <1313002585.1674.13.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Avi Kivity <avi@redhat.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.08.2011, at 20:56, Benjamin Herrenschmidt wrote:

> On Wed, 2011-08-10 at 16:58 +0200, Alexander Graf wrote:
>> On 08/03/2011 08:55 PM, Nishanth Aravamudan wrote:
>>> On a box with gcc 4.3.2, I see errors like:
>>>=20
>>> arch/powerpc/kvm/book3s_hv_rmhandlers.S:1254: Error: Unrecognized =
opcode: stxvd2x
>>> arch/powerpc/kvm/book3s_hv_rmhandlers.S:1316: Error: Unrecognized =
opcode: lxvd2x
>>=20
>> Paul, mind to ack?
>=20
> I merged it already :-) It was trivial & annoying enough.

Alright then, I won't touch it :)


Alex
