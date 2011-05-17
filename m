Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A11ABB6EF3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 21:42:14 +1000 (EST)
Message-ID: <4DD25F10.4030707@redhat.com>
Date: Tue, 17 May 2011 14:42:08 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/13] Hypervisor-mode KVM on POWER7
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
	<20110517111536.GC7924@brick.ozlabs.ibm.com>
	<14CFAA70-1747-4902-8CC1-4BE924CAD031@suse.de>
In-Reply-To: <14CFAA70-1747-4902-8CC1-4BE924CAD031@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/17/2011 02:38 PM, Alexander Graf wrote:
> >
> >  What would be the path for these patches to get upstream?  Would this
> >  stuff normally go through Avi's tree?  There is a bit of a
> >  complication in that they are based on Ben's next branch.  Would Avi
> >  pull Ben's next branch, or would they go in via Ben's tree?
>
> Usually the ppc tree gets merged into Avi's tree and goes on from there. When we have interdependencies, we can certainly do it differently though. We can also shove them through Ben's tree this time around, as there are more dependencies on ppc code than KVM code.
>

Yes, both options are fine.  If it goes through kvm.git I can merge 
Ben's tree (provided it is append-only) and apply the kvm-ppc patches on 
top.

-- 
error compiling committee.c: too many arguments to function
