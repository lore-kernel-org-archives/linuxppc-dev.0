Return-Path: <caleb@crome.org>
Received: from mail-pl0-x229.google.com (mail-pl0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCJLw0GPJzF0R1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 06:50:47 +1100 (AEDT)
Received: by mail-pl0-x229.google.com with SMTP id 1so1640918plv.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 11:50:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180104194842.GE27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <CAG5mAdxBOvrE3U-PAZVKepZfTZc91kKOLrC_UoMnBsoZvJ9hyA@mail.gmail.com>
 <20180104194842.GE27975@Asurada-Nvidia>
From: Caleb Crome <caleb@crome.org>
Date: Thu, 4 Jan 2018 11:50:24 -0800
Message-ID: <CAG5mAdwDo0RV59HDgXNj3rGwBbu_RuGjTVPifWALmsq27ADz5Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 4, 2018 at 11:48 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Jan 02, 2018 at 03:28:11PM -0800, Caleb Crome wrote:
>
>> tested this patch set on MX6 SSI against broonie for-next (4.15-rc5),
>> no problems.
>> Do I send a separate Tested-by for each patch, or just the 00/15 one?
>
>> Tested-by: Caleb Crome <caleb@crome.org>
>
> I will include your Tested-by to each patch in v2 unless there is
> going to be a critical change suggested by the future reviews so
> that we need another round of full testing. Thank you

Great.

-Caleb
