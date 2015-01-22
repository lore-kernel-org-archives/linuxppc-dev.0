Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BE9E1A0E45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 22:31:03 +1100 (AEDT)
Date: Thu, 22 Jan 2015 22:31:00 +1100
From: Anton Blanchard <anton@samba.org>
To: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 1/2] oprofile: Add HAVE_OPROFILE_NMI_TIMER
Message-ID: <20150122223100.1d234565@kryten>
In-Reply-To: <20150121182015.GA4201@rric.localhost>
References: <1421811983-22788-1-git-send-email-anton@samba.org>
 <20150121225408.33194932@kryten>
 <20150121182015.GA4201@rric.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: x86@kernel.org, mingo@redhat.com, paulus@samba.org, hpa@zytor.com,
 oprofile-list@lists.sf.net, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Robert,

> I also don't see a reason, why you don't want to support oprofile NMI
> timer. Is there any?

I couldn't come up with a case where it would be a benefit to us. We
roll out PMU support for a new CPU early so that the kernel and tools
support it when we GA. On the other hand adding oprofile NMI support
will put pressure on us to add more test cases.

> If you don't want NMI_TIMER being enabled, then (order of preference):
> 
>  * disable it with oprofile (OPROFILE dependency needed for
>    NMI_TIMER), or
> 
>  * make the default value for NMI_TIMER !PPC64 and add a prompt to let
>    the user select/deselect it, or
> 
>  * disable OPROFILE_NMI_TIMER by adding a !PPC64 dependency.

I'll rework and resubmit. Thanks.

Anton
