Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA361B6FCB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 18:17:44 +1000 (EST)
Received: by vwl1 with SMTP id 1so591698vwl.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 01:17:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110622032013.GA28610@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413__14973.6630417921$1308385948$gmane$org@bloggs.ozlabs.ibm.com>
	<itq97v$dc$1@dough.gmane.org>
	<20110622032013.GA28610@bloggs.ozlabs.ibm.com>
Date: Wed, 22 Jun 2011 12:17:39 +0400
Message-ID: <BANLkTikh1+q_ZbzEE2yAbAM043aHmNZZkw@mail.gmail.com>
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/22/11, Paul Mackerras <paulus@samba.org> wrote:
> On Tue, Jun 21, 2011 at 02:18:39PM +0000, Dmitry Eremin-Solenikov wrote:
>
>> I have a Maple board (dual PPC970FX). Will this patchset work on it?
>> Should I add any additional changes to add support for this platform?
>
> Provided the firmware gives you control in hypervisor mode, yes it
> should work, and I don't know of any extra changes you would need.
> I don't recall what firmware the Maple boards had on them, though.

On my board I have a PIBS firmware which programs all PPC970 registers
with special script. I think one of the scripts bears "hypervisor" settings,
so I'll try to give this patchset a try.

-- 
With best wishes
Dmitry
