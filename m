Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F5EDB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 05:24:32 +1000 (EST)
Date: Wed, 29 Jun 2011 14:24:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: ashwath narasimhan <ashwath.narasimhan@oneconvergence.com>
Subject: Re: perf_event_open system call support in powerpc
Message-ID: <20110629142419.65e96543@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTi=j1FwEv2tBmPck3GWHWgcYGchcew@mail.gmail.com>
References: <BANLkTi=j1FwEv2tBmPck3GWHWgcYGchcew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2011 20:03:10 -0700
ashwath narasimhan <ashwath.narasimhan@oneconvergence.com> wrote:

> Hello,
> 
>  I am new to the powerpc architecture and I am trying to use
> perf_event_open() system call for power pc architecture (e500mc) using
> 2.6.32 kernel distribution. Is this system call number supported for power
> pc architecture? 

perf event support for e500mc wasn't added until 2.6.34.

-Scott
