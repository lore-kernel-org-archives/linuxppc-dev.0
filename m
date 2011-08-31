Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B85BB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 08:37:18 +1000 (EST)
Date: Wed, 31 Aug 2011 15:36:33 -0700
From: Greg KH <greg@kroah.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
Message-ID: <20110831223633.GC27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
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

On Tue, Aug 30, 2011 at 08:29:21AM -0700, Tirumala Marri wrote:
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
> < include/linux/usb/dwc_otg.h |  274
> 
> [Tirumala Marri] I am not sure how to separate your changes. But we need
> More time as our initial patches are still pending.

pending where?  Have you submitted them for inclusion?

confused,

greg k-h
