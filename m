Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9B1B5B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jan 2010 00:10:35 +1100 (EST)
Message-ID: <4B433A3C.3010206@redhat.com>
Date: Tue, 05 Jan 2010 15:10:20 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: powerpc: allmod config build failure
References: <20100105143238.ed113985.sfr@canb.auug.org.au>
	<04B8CF10-6D9F-477F-8500-043EA0DEBD78@suse.de>
In-Reply-To: <04B8CF10-6D9F-477F-8500-043EA0DEBD78@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2010 03:03 PM, Alexander Graf wrote:
> On 05.01.2010, at 04:32, Stephen Rothwell wrote:
>
>    
>> Hi all,
>>
>> The powerpc allmodconfig build of Linus' tree has been failing like this
>> since Dec 13 (and linux-next since Nov 7):
>>
>> arch/powerpc/kvm/built-in.o:(.toc1+0x18): undefined reference to `kvm_debugfs_dir'
>>
>> $ grep KVM .config
>> CONFIG_KVM=y
>> CONFIG_KVM_BOOK3S_64_HANDLER=y
>> CONFIG_KVM_BOOK3S_64=m
>> CONFIG_KVM_EXIT_TIMING=y
>>
>> I assume that this failure was introduced by commit
>> c4f9c779f1019c7d5c61961a7c0aaaf1420d8f90 ("Include Book3s_64 target in
>> buildsystem").
>>      
> Yes, and the fix is in Avi's tree already (1231730604360801d4e648c37c4b98f30850e001).
> I'm not sure how the syncing of those two happens - let's ask him.
>    

Marcelo and myself collect such patches in a branch (kvm.git 
kvm-updates/2.6.33) and push them to Linus.  This week it's Marcelo's turn.

When sending a patch that fixes upstream (or -stable) breakage, please 
not it explicitly, and we'll queue it when applying.

-- 
error compiling committee.c: too many arguments to function
