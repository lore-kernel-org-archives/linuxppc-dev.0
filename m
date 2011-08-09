Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 403F3B70C6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 08:10:04 +1000 (EST)
Subject: Re: [PATCH 07/10] KVM: PPC: Add PAPR hypercall code for PR mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4E4167F9.5090305@redhat.com>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-8-git-send-email-agraf@suse.de>
	<4E416315.2080800@redhat.com> <4E41646C.1070500@suse.de>
	<4E41651C.7050709@redhat.com> <4E4165AB.8030704@suse.de>
	<4E4167F9.5090305@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Aug 2011 17:02:00 -0500
Message-ID: <1312927320.29273.19.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-09 at 20:01 +0300, Avi Kivity wrote:
> On 08/09/2011 07:51 PM, Alexander Graf wrote:
> >> Just put your own (or your employers').  If someone contributed to 
> >> the code they can add their copyrights (or ask you do do it before 
> >> inclusion).
> >>
> >> It would be good to get Paul's or Ben's so that the unimportant 
> >> characters between the whitespace get some braintime.
> >
> >
> > So you mean I just put both copyright statements there? That's a nice 
> > idea!
> >
> >
> 
> I meant Paul's or Ben's *review*.

Ben's currently travelling doing some bringup :-) I will try to have a
look but I can't promise anything for the next 2 weeks.

Cheers,
Ben.
