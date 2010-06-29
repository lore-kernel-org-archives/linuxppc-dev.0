Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id EB9F3B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 20:55:29 +1000 (EST)
Message-ID: <4C29D11D.6050006@redhat.com>
Date: Tue, 29 Jun 2010 13:55:25 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 01/26] KVM: PPC: Introduce shared page
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-2-git-send-email-agraf@suse.de>
	<4C274028.7020105@redhat.com> <4C29C2E1.4000706@suse.de>
In-Reply-To: <4C29C2E1.4000706@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/29/2010 12:54 PM, Alexander Graf wrote:
>
>> Code repeats 3x.  Share please.
>>      
> Looking at this again, I could combine the 3 lines of init code into 3
> lines of code that do a generic function call and then error checking.
> And I could convert the one free_page line with one function call that
> would free the page. Is there a real gain behind this?
>
>    

Looks marginal, yes.  It will help if initialization is expanded later, 
but currently it doesn't help much.

-- 
error compiling committee.c: too many arguments to function
