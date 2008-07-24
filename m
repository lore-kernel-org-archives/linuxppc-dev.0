Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id D5956DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 12:01:13 +1000 (EST)
Date: Thu, 24 Jul 2008 12:01:12 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 0/6][RFC] kvmppc: paravirtualization interface
Message-ID: <20080724020112.GM20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 10:36:41AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> 
> This patch series implements a paravirtualization interface using:
> - the device tree mechanism to pass hypervisor informations to the guest
> - hypercalls for guest->host calls
> - an example exploiter of that interface (magic page)
> This is work in progress, but working so far. I just start to really exploit
> the fuctionality behind the magic page mechanism therefor I can't provide any
> performance improvements so far, but it is evolved enough for RFC and to start
> the standardization discussion.

Are you aiming this for the current merge window, ie for 2.6.27?

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
