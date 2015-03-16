Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21F861A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 06:30:32 +1100 (AEDT)
Message-ID: <55072CEE.7060103@tabi.org>
Date: Mon, 16 Mar 2015 14:20:14 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/35 linux-next] tty: constify of_device_id array
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Alexandre Courbot <gnurou@gmail.com>, Barry Song <baohua@kernel.org>,
 kernel@stlinux.com, Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Patrice Chotard <patrice.chotard@st.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 linux-tegra@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
 =?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Maxime Coquelin <maxime.coquelin@st.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2015 02:17 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick<fabf@skynet.be>

...

>   drivers/tty/serial/ucc_uart.c               | 2 +-

For this driver:

Acked-by: Timur Tabi <timur@tabi.org>
