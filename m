Return-Path: <tmarri@apm.com>
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
	by ozlabs.org (Postfix) with SMTP id A2A7AB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 01:35:32 +1000 (EST)
Received: by qwj8 with SMTP id 8so5138735qwj.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:35:29 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
In-Reply-To: <d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Date: Tue, 30 Aug 2011 08:29:21 -0700
Message-ID: <9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
Subject: RE: [PATCH 02/14] dwc/otg: Structure declaration for shared data
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
<Subject: [PATCH 02/14] dwc/otg: Structure declaration for shared data
<
<There are some DWC OTG parameters which might be passed by a platform.
<Declaration for structure of those parameters have been provided in this
<include file.
<
<Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
<---
< include/linux/usb/dwc_otg.h |  274

[Tirumala Marri] I am not sure how to separate your changes. But we need
More time as our initial patches are still pending.
--marri
