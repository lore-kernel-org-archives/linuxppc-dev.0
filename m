Return-Path: <richardcochran@gmail.com>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com
 [IPv6:2a00:1450:400c:c05::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2860D1A084F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 08:31:32 +1100 (AEDT)
Received: by mail-wi0-f171.google.com with SMTP id l15so15576526wiw.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 13:31:28 -0800 (PST)
Date: Wed, 28 Jan 2015 22:31:23 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
Message-ID: <20150128213123.GA27411@localhost.localdomain>
References: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501211243270.5526@nanos>
 <54C09391.9080202@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1501221209260.5526@nanos>
 <54C7068B.3050108@linux.vnet.ibm.com>
 <54C8B3D2.3070608@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54C8B3D2.3070608@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
 Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 28, 2015 at 03:32:58PM +0530, Preeti U Murthy wrote:
> Thomas ping. Would you be posting this patch?

FYI, Thomas is temporarily out of action, in bed with the flu.

Thanks,
Richard
