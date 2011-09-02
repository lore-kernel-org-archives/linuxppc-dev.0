Return-Path: <greg@kroah.com>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DF2DB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Sep 2011 10:20:01 +1000 (EST)
Date: Fri, 2 Sep 2011 06:57:51 -0700
From: Greg KH <greg@kroah.com>
To: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
Message-ID: <20110902135751.GB28815@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<20110831223604.GB27818@kroah.com>
	<CAHM4w1npnX9ELf6AypR7+3D55qUw3Euz0dT_rb7UOj=1buuN+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAHM4w1npnX9ELf6AypR7+3D55qUw3Euz0dT_rb7UOj=1buuN+A@mail.gmail.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
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

On Fri, Sep 02, 2011 at 05:19:17PM +0530, Pratyush Anand wrote:
> On Thu, Sep 1, 2011 at 4:06 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Aug 30, 2011 at 05:27:49PM +0530, Pratyush Anand wrote:
> >> There are some DWC OTG parameters which might be passed by a platform.
> >> Declaration for structure of those parameters have been provided in this
> >> include file.
> >>
> >> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> >> ---
> >>  include/linux/usb/dwc_otg.h |  274 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 274 insertions(+), 0 deletions(-)
> >>  create mode 100644 include/linux/usb/dwc_otg.h
> >>
> >> diff --git a/include/linux/usb/dwc_otg.h b/include/linux/usb/dwc_otg.h
> >
> > Shouldn't this be in include/linux/platform/ instead?
> 
> do you mean linux/platform_data/?

Yes, sorry.
