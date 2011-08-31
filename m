Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 403E2B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 08:37:17 +1000 (EST)
Date: Wed, 31 Aug 2011 15:36:04 -0700
From: Greg KH <greg@kroah.com>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
Message-ID: <20110831223604.GB27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2011 at 05:27:49PM +0530, Pratyush Anand wrote:
> There are some DWC OTG parameters which might be passed by a platform.
> Declaration for structure of those parameters have been provided in this
> include file.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  include/linux/usb/dwc_otg.h |  274 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 274 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/usb/dwc_otg.h
> 
> diff --git a/include/linux/usb/dwc_otg.h b/include/linux/usb/dwc_otg.h

Shouldn't this be in include/linux/platform/ instead?
