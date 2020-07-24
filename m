Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE7C433EB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:17:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2373922B40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2373922B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCrrK0xkZzF13V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 00:17:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgC5QKNzDrBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:24:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgC1ZRDz9sTF; Fri, 24 Jul 2020 23:24:38 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20200709032946.881753-1-aneesh.kumar@linux.ibm.com>
References: <20200709032946.881753-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6 00/23] powerpc/book3s/64/pkeys: Simplify the code
Message-Id: <159559696499.1657499.11980324722144853540.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:24:38 +1000 (AEST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxram@us.ibm.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 9 Jul 2020 08:59:23 +0530, Aneesh Kumar K.V wrote:
> This patch series update the pkey subsystem with more documentation and
> rename variables so that it is easy to follow the code. We drop the changes
> to support KUAP/KUEP with hash translation in this update. The changes
> are adding 200 cycles to null syscalls benchmark and I want to look at that
> closely before requesting a merge. The rest of the patches are included
> in this series. This should avoid having to carry a large patchset across
> the upstream merge. Some of the changes in here make the hash KUEP/KUAP
> addition simpler.
> 
> [...]

Applied to powerpc/next.

[01/23] powerpc/book3s64/pkeys: Use PVR check instead of cpu feature
        https://git.kernel.org/powerpc/c/d79e7a5f26f1d179cbb915a8bf2469b6d7431c29
[02/23] powerpc/book3s64/pkeys: Fixup bit numbering
        https://git.kernel.org/powerpc/c/33699023f51f96ac9be38747e64967ea05e00bab
[03/23] powerpc/book3s64/pkeys: pkeys are supported only on hash on book3s.
        https://git.kernel.org/powerpc/c/b9658f83e721ddfcee3e08b16a6628420de424c3
[04/23] powerpc/book3s64/pkeys: Move pkey related bits in the linux page table
        https://git.kernel.org/powerpc/c/ee8b39331f89950b0a011c7965db5694f0153166
[05/23] powerpc/book3s64/pkeys: Explain key 1 reservation details
        https://git.kernel.org/powerpc/c/1f404058e2911afe08417ef82f17aba6adccfc63
[06/23] powerpc/book3s64/pkeys: Simplify the key initialization
        https://git.kernel.org/powerpc/c/f491fe3fb41eafc7a159874040e032ad41ade210
[07/23] powerpc/book3s64/pkeys: Prevent key 1 modification from userspace.
        https://git.kernel.org/powerpc/c/718d9b380174eb8fe16d67769395737b79654a02
[08/23] powerpc/book3s64/pkeys: kill cpu feature key CPU_FTR_PKEY
        https://git.kernel.org/powerpc/c/a24204c307962214996627e3f4caa8772b9b0cf4
[09/23] powerpc/book3s64/pkeys: Simplify pkey disable branch
        https://git.kernel.org/powerpc/c/a4678d4b477c3d2901f101986ca01406f3b7eaea
[10/23] powerpc/book3s64/pkeys: Convert pkey_total to num_pkey
        https://git.kernel.org/powerpc/c/c529afd7cbc71ae1dc44a31efc7c1c9db3c3a143
[11/23] powerpc/book3s64/pkeys: Make initial_allocation_mask static
        https://git.kernel.org/powerpc/c/3c8ab47362fe9a74f61b48efe957666a423c55a2
[12/23] powerpc/book3s64/pkeys: Mark all the pkeys above max pkey as reserved
        https://git.kernel.org/powerpc/c/3e4352aeb8b17eb1040ba288f586620e8294389d
[13/23] powerpc/book3s64/pkeys: Add MMU_FTR_PKEY
        https://git.kernel.org/powerpc/c/d3cd91fb8d2e202cf8ebb6f271898aaf37ecda8f
[14/23] powerpc/book3s64/kuep: Add MMU_FTR_KUEP
        https://git.kernel.org/powerpc/c/e10cc8715d180509a367d3ab25d40e4a1612cb2f
[15/23] powerpc/book3s64/pkeys: Use pkey_execute_disable_supported
        https://git.kernel.org/powerpc/c/2daf298de728dc37f32d0749fa4f59db36fa7d96
[16/23] powerpc/book3s64/pkeys: Use MMU_FTR_PKEY instead of pkey_disabled static key
        https://git.kernel.org/powerpc/c/f7045a45115b17fe695ea7075f5213706f202edb
[17/23] powerpc/book3s64/keys: Print information during boot.
        https://git.kernel.org/powerpc/c/7cdd3745f2d75aecc2b61368e2563ae54bfac59a
[18/23] powerpc/book3s64/keys/kuap: Reset AMR/IAMR values on kexec
        https://git.kernel.org/powerpc/c/000a42b35a54372597f0657f6b9875b38c641864
[19/23] powerpc/book3s64/kuap: Move UAMOR setup to key init function
        https://git.kernel.org/powerpc/c/e0d8e991be641ba0034c67785bf86f6c097869d6
[20/23] selftests/powerpc: ptrace-pkey: Rename variables to make it easier to follow code
        https://git.kernel.org/powerpc/c/9a11f12e0a6c374b3ef1ce81e32ce477d28eb1b8
[21/23] selftests/powerpc: ptrace-pkey: Update the test to mark an invalid pkey correctly
        https://git.kernel.org/powerpc/c/0eaa3b5ca7b5a76e3783639c828498343be66a01
[22/23] selftests/powerpc: ptrace-pkey: Don't update expected UAMOR value
        https://git.kernel.org/powerpc/c/3563b9bea0ca7f53e4218b5e268550341a49f333
[23/23] powerpc/book3s64/pkeys: Remove is_pkey_enabled()
        https://git.kernel.org/powerpc/c/482b9b3948675df60c015b2155011c1f93234992

cheers
