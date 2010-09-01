Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2160AB7160
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 17:50:09 +1000 (EST)
Message-ID: <4C7E05AB.40608@redhat.com>
Date: Wed, 01 Sep 2010 10:50:03 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PULL 00/35] KVM: PPC: End-August patch queue
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 08/31/2010 05:31 AM, Alexander Graf wrote:
> Howdy,
>
> This is my local patch queue with stuff that has accumulated over the last
> weeks on KVM for PPC with some last minute fixes, speedups and debugging help
> that I needed for the KVM Forum ;-).
>
> The highlights of this set are:
>
>    - Converted most important debug points to tracepoints
>    - Flush less PTEs (speedup)
>    - Go back to our own hash (less duplicates)
>    - Make SRs guest settable (speedup for 32 bit guests)
>    - Remove r30/r31 restrictions from PV hooks (speedup!)
>    - Fix random breakages
>    - Fix random guest stalls
>    - 440GP host support (Thanks Hollis!)
>    - Reliable interrupt injection
>
> Keep in mind that this is the first version that is stable on PPC32 hosts.
> All versions prior to this could occupy otherwise used segment entries and
> thus crash your machine :-).
>
> It is also the first version that is stable with PPC64 guests, because they
> require more sophisticated interrupt injection logic for which qemu patches
> are also required.
>
> Please pull this tree from:
>
>      git://github.com/agraf/linux-2.6.git kvm-ppc-next
>
> Have fun with more accurate, faster and less buggy KVM on PowerPC!

Pulled, thanks.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
