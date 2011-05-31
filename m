Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FDFBB6F75
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 22:50:27 +1000 (EST)
Subject: Re: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110531123521.GL2505@brick.ozlabs.ibm.com>
Date: Tue, 31 May 2011 14:50:20 +0200
Message-Id: <A857E6BF-D88C-46E3-BF09-268A43B7F7CF@suse.de>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
	<B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
	<20110531123521.GL2505@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.05.2011, at 14:35, Paul Mackerras wrote:

> On Tue, May 31, 2011 at 12:40:31PM +0200, Alexander Graf wrote:
>=20
>> Thinking about the testability of this a bit more ... how much
>> effort would it be to get this code running on a 970MP with SLOF?
>> There should only be a few POWER7 specific pieces, right?
>=20
> Do you have a 970MP that has a usable hypervisor mode, i.e. not an
> Apple machine?  The 970s in Apple machines have the HV hard-wired to
> 1, which means they do have a hypervisor mode but it isn't any use.
>=20
> If you do have such a machine, then we would have to look at some
> details like the instruction sequence for the partition switch, and
> make sure we don't try to use SMT4 mode.  Also, I believe we will have
> to flush the TLB on partition switches, since Power processors prior
> to POWER7 didn't tag the TLB entries with the partition ID.
>=20
> So it should be quite feasible if you have a non-Apple machine.
> I will check whether the 970MP machines that Terrasoft were
> distributing would be suitable.  We have one of them in the lab.

That's the one I was thinking of and yes, I have one available. That way =
I could test 99% of your code, you don't have to release hardware, and =
everyone's happy :).


Alex
