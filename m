Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6A59B71CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 12:08:34 +1000 (EST)
Subject: Re: [bg-linux] [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kazutomo Yoshii <kazutomo.yoshii@gmail.com>
In-Reply-To: <4DD5C49E.4050103@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-5-git-send-email-ericvh@gmail.com>
	<1305851769.7481.90.camel@pasglop>  <4DD5C49E.4050103@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 12:08:21 +1000
Message-ID: <1305857301.7481.121.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 20:32 -0500, Kazutomo Yoshii wrote:
> 
> Actually DMA sends invalidate requests to the snoop unit(L2 level).
> BGP SoC is a bit different from other 4xx base. 

Well, some other 44x also have a snooping L2 (more or less), but L1 is
usually the problem.

Cheers,
Ben.
