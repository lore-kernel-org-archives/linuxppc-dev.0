Return-Path: <tmarri@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 6D576B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 01:32:54 +1000 (EST)
Received: by mail-yi0-f43.google.com with SMTP id 27so5354147yia.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:32:53 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
In-Reply-To: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Date: Tue, 30 Aug 2011 08:27:30 -0700
Message-ID: <bff62861217ab3d8dbf8041e2c4d1c8c@mail.gmail.com>
Subject: RE: [PATCH 00/14] Modifications for DWC OTG since v13
To: Pratyush Anand <pratyush.anand@st.com>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, Mark Miesfeld <mmiesfeld@apm.com>,
	deepak.sikri@st.com, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<-----Original Message-----
<From: Pratyush Anand [mailto:pratyush.anand@st.com]
<Sent: Tuesday, August 30, 2011 4:58 AM
<To: linux-usb@vger.kernel.org
<Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
<mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
<vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
<bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyush
<Anand
<Subject: [PATCH 00/14] Modifications for DWC OTG since v13
<
<These patches are based on:http://patchwork.ozlabs.org/patch/89560/
<After not getting any reply from developers, I started to do
<modifications for my platform (SPEAr1340).
<I have done modifications in such a way that all the code in
<driver/usb/dwc/ would be platform independent.
<I have tested this code for host/device/dma/slave mode.
<My fifo configuration is dedicated and dynamic.

[Tirumala Marri] We are working on our next release of patches. They
should be coming out soon.
