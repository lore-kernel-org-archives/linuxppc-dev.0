Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C58D11A0611
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 09:34:22 +1000 (EST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B4F120F7B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 19:25:37 -0400 (EDT)
Date: Thu, 29 May 2014 16:25:34 -0700
From: Greg KH <greg@kroah.com>
To: abdoulaye berthe <berthe.ab@gmail.com>
Subject: Re: [PATCH] gpio: removes all usage of gpiochip_remove retval
Message-ID: <20140529232534.GA11741@kroah.com>
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
Cc: devel@driverdev.osuosl.org, gnurou@gmail.com,
 patches@opensource.wolfsonmicro.com, linux-mips@linux-mips.org,
 netdev@vger.kernel.org, linus.walleij@linaro.org, linux-sh@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 spear-devel@list.st.com, linux-samsungsoc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org, m@bues.ch,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 29, 2014 at 11:54:52PM +0200, abdoulaye berthe wrote:
> Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>

Why?
