Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2850AB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:10:32 +1000 (EST)
Message-ID: <4C305001.7060301@redhat.com>
Date: Sun, 04 Jul 2010 12:10:25 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
	<79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
In-Reply-To: <79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2010 12:04 PM, Alexander Graf wrote:
>
> My biggest concern about putting things in the device-tree is that I was trying to keep things as separate as possible. Why does the firmware have to know that it's running in KVM?

It doesn't need to know about kvm, it needs to know that a particular 
hypercall protocol is available.

> Why do I have to patch 3 projects (Linux, OpenBIOS, Qemu) when I could go with patching a single one (Linux)?
>    

That's not a valid argument.  You patch as many projects as it takes to 
get it right (not that I have an opinion in this particular discussion).

At the very least you have to patch qemu for reasons described before 
(backwards compatible live migration).

-- 
error compiling committee.c: too many arguments to function
