Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0hT23XRzF1yq
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:08:40 +1100 (AEDT)
Date: Sat, 31 Mar 2018 16:08:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wasim Nazir <wasim.nazir@pathpartnertech.com>
Cc: jhogan@kernel.org, kys@microsoft.com, linuxdrivers@attotech.com,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 linux-arm-kernel@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, David Daney <david.daney@cavium.com>,
 Mihaela Muraru <mihaela.muraru21@gmail.com>,
 Kishore KP <kishore.p@techveda.org>, Sidong Yang <realwakka@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Phil Elwell <phil@raspberrypi.org>, Ingo Molnar <mingo@kernel.org>,
 Tycho Andersen <tycho@tycho.ws>, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] Patch to replace DEFINE_SEMAPHORE with
 DEFINE_BINARY_SEMAPHORE
Message-ID: <20180331140832.GA1074@kroah.com>
References: <CAAYn-eg8L=-2rX4ZcsA6r9J+6ESEvQFrWk1=f+k1ToP2f=6WHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAYn-eg8L=-2rX4ZcsA6r9J+6ESEvQFrWk1=f+k1ToP2f=6WHQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 31, 2018 at 07:16:21PM +0530, Wasim Nazir wrote:
> This message contains confidential information and is intended only for the 
> individual(s) named. If you are not the intended recipient, you are 
> notified that disclosing, copying, distributing or taking any action in 
> reliance on the contents of this mail and attached file/s is strictly 
> prohibited. Please notify the sender immediately and delete this e-mail 
> from your system. E-mail transmission cannot be guaranteed to be secured or 
> error-free as information could be intercepted, corrupted, lost, destroyed, 
> arrive late or incomplete, or contain viruses. The sender therefore does 
> not accept liability for any errors or omissions in the contents of this 
> message, which arise as a result of e-mail transmission.


This footer is not compatible with patches submitted to the kernel,
sorry.  email is now deleted.

greg k-h
