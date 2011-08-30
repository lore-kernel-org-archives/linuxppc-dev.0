Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B220B7214
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 01:46:58 +1000 (EST)
Received: by gyd8 with SMTP id 8so5930790gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:46:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bff62861217ab3d8dbf8041e2c4d1c8c@mail.gmail.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<bff62861217ab3d8dbf8041e2c4d1c8c@mail.gmail.com>
Date: Tue, 30 Aug 2011 21:16:53 +0530
Message-ID: <CAHM4w1nWTxfMTSTbmt4vnWAKhj4JisJf1f0SjirOt7Z9vjORoA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Modifications for DWC OTG since v13
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Tirumala Marri <tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	Mark Miesfeld <mmiesfeld@apm.com>, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2011 at 8:57 PM, Tirumala Marri <tmarri@apm.com> wrote:
> <-----Original Message-----
> <From: Pratyush Anand [mailto:pratyush.anand@st.com]
> <Sent: Tuesday, August 30, 2011 4:58 AM
> <To: linux-usb@vger.kernel.org
> <Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
> <mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
> <vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
> <bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyush
> <Anand
> <Subject: [PATCH 00/14] Modifications for DWC OTG since v13
> <
> <These patches are based on:http://patchwork.ozlabs.org/patch/89560/
> <After not getting any reply from developers, I started to do
> <modifications for my platform (SPEAr1340).
> <I have done modifications in such a way that all the code in
> <driver/usb/dwc/ would be platform independent.
> <I have tested this code for host/device/dma/slave mode.
> <My fifo configuration is dedicated and dynamic.
>
> [Tirumala Marri] We are working on our next release of patches. They
> should be coming out soon.

Oh, thats great !!
Actually, I did not get any reply of my previous mail on your patch release=
.
I thought no one is maintaining., and so I sent them with my modifications,
after testing them in all dev/host/otg mode.

Regards
Pratyush

> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
