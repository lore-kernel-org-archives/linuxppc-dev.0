Return-Path: <jacmet@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA8801A09B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 06:51:39 +1100 (AEDT)
Received: by wifj2 with SMTP id j2so52839390wif.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 12:51:36 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <peter@korsgaard.com>
To: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 05/35 linux-next] tty: constify of_device_id array
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
Date: Mon, 16 Mar 2015 20:51:34 +0100
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be> (Fabian
 Frederick's message of "Mon, 16 Mar 2015 20:17:11 +0100")
Message-ID: <878uewen5l.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre Courbot <gnurou@gmail.com>, Barry Song <baohua@kernel.org>,
 Timur Tabi <timur@tabi.org>, kernel@stlinux.com,
 Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 linux-tegra@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
 Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?Q?S=C3=B6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 Maxime Coquelin <maxime.coquelin@st.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Fabian" == Fabian Frederick <fabf@skynet.be> writes:

 > of_device_id is always used as const.
 > (See driver.of_match_table and open firmware functions)

 > Signed-off-by: Fabian Frederick <fabf@skynet.be>
 > ---

For this:

>  drivers/tty/serial/uartlite.c               | 2 +-

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
