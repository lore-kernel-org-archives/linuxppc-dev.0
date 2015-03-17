Return-Path: <patrice.chotard@st.com>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 596271A02D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 19:54:15 +1100 (AEDT)
Message-ID: <5507E17D.2050701@st.com>
Date: Tue, 17 Mar 2015 09:10:37 +0100
From: Patrice Chotard <patrice.chotard@st.com>
MIME-Version: 1.0
To: Fabian Frederick <fabf@skynet.be>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/35 linux-next] tty: constify of_device_id array
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: Alexandre Courbot <gnurou@gmail.com>, Barry Song <baohua@kernel.org>,
 kernel@stlinux.com, Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@tabi.org>, Michal Simek <michal.simek@xilinx.com>,
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

Hi Fabian

On 03/16/2015 08:17 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
....
>   drivers/tty/serial/st-asc.c                 | 2 +-
>
For this driver

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
