Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26072B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 01:43:45 +1000 (EST)
Received: by ywt32 with SMTP id 32so5861213ywt.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:43:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
Date: Tue, 30 Aug 2011 21:13:42 +0530
Message-ID: <CAHM4w1nHQ1arnTjFyp4dbmp1SBWKJPfREOOR_yykfaVyS48-iA@mail.gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
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

On Tue, Aug 30, 2011 at 8:59 PM, Tirumala Marri <tmarri@apm.com> wrote:
> <-----Original Message-----
> <From: Pratyush Anand [mailto:pratyush.anand@st.com]
> <Sent: Tuesday, August 30, 2011 4:58 AM
> <To: linux-usb@vger.kernel.org
> <Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
> <mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
> <vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
> <bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyush
> <Anand
> <Subject: [PATCH 02/14] dwc/otg: Structure declaration for shared data
> <
> <There are some DWC OTG parameters which might be passed by a platform.
> <Declaration for structure of those parameters have been provided in this
> <include file.
> <
> <Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> <---
> < include/linux/usb/dwc_otg.h | =A0274
>
> [Tirumala Marri] I am not sure how to separate your changes. But we need
> More time as our initial patches are still pending.
> --marri

Tirumala,

If you agree , then I can send you modifications which I did over your
patches(v13) separately,
and then you can decide the final inclusion of only these modifications.

Regards
Pratyush

> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
