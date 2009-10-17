Return-Path: <timur.tabi@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id B8A8FB7B74
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 10:18:01 +1100 (EST)
Received: by fxm21 with SMTP id 21so3696057fxm.9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 16:17:59 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20091016084924.GB4234@linux.vnet.ibm.com>
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910152041.26646.borntraeger@de.ibm.com>
	<4AD770A9.6070509@freescale.com>
	<200910152126.28024.borntraeger@de.ibm.com>
	<4AD778E6.7020806@freescale.com>
	<20091016084924.GB4234@linux.vnet.ibm.com>
Date: Sat, 17 Oct 2009 18:17:58 -0500
Message-ID: <ed82fe3e0910171617v6cdec1f9r9dc33cfb8852a31a@mail.gmail.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
From: Timur Tabi <timur@freescale.com>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2009 at 3:49 AM, Hendrik Brueckner
<brueckner@linux.vnet.ibm.com> wrote:

> The states are handled by the hvc_iucv itself:
> If the hvc_iucv code has a connection established, terminal or console data
> are queued and sent to the peer. If the state is disconnected, terminal and
> console data is discarded internally.

So what is the plan now?

-- 
Timur Tabi
Linux kernel developer at Freescale
