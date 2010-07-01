Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38BFE1007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 22:25:11 +1000 (EST)
Message-ID: <4C2C891E.4030202@suse.de>
Date: Thu, 01 Jul 2010 14:25:02 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/27] KVM: PPC: Magic Page BookE support
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-15-git-send-email-agraf@suse.de>
	<20100701111823.GE7756@zod.rchland.ibm.com>
In-Reply-To: <20100701111823.GE7756@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Josh Boyer wrote:
> On Thu, Jul 01, 2010 at 12:42:49PM +0200, Alexander Graf wrote:
>   
>> As we now have Book3s support for the magic page, we also need BookE to
>> join in on the party.
>>
>> This patch implements generic magic page logic for BookE and specific
>> TLB logic for e500. I didn't have any 440 around, so I didn't dare to
>> blindly try and write up broken code.
>>     
>
> Is this the only patch in the series that needs 440 specific code?  Also,
> does 440 KVM still work after this series is applied even without the code
> not present in this patch?
>   

Yes, pretty much. The rest of the code is generic. But 440 should easily
just work with this patch set. If you have one to try it out, please
give it a try. I can even prepare a 440 enabling patch so you could
verify if it works.

Alex
