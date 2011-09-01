Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCBBAB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 11:54:33 +1000 (EST)
Date: Wed, 31 Aug 2011 18:37:05 -0700
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
Message-ID: <20110901013705.GA15942@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
	<20110831223633.GC27818@kroah.com>
	<CA+5PVA569eWwYvU9Ghs6yGNimTPDX0+fbmouMV2yuxjyA7J4+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+5PVA569eWwYvU9Ghs6yGNimTPDX0+fbmouMV2yuxjyA7J4+g@mail.gmail.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	Tirumala Marri <tmarri@apm.com>, linux-usb@vger.kernel.org,
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

On Wed, Aug 31, 2011 at 08:18:12PM -0400, Josh Boyer wrote:
> On Wed, Aug 31, 2011 at 6:36 PM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Aug 30, 2011 at 08:29:21AM -0700, Tirumala Marri wrote:
> >> <-----Original Message-----
> >> <From: Pratyush Anand [mailto:pratyush.anand@st.com]
> >> <Sent: Tuesday, August 30, 2011 4:58 AM
> >> <To: linux-usb@vger.kernel.org
> >> <Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
> >> <mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
> >> <vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
> >> <bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyush
> >> <Anand
> >> <Subject: [PATCH 02/14] dwc/otg: Structure declaration for shared data
> >> <
> >> <There are some DWC OTG parameters which might be passed by a platform.
> >> <Declaration for structure of those parameters have been provided in this
> >> <include file.
> >> <
> >> <Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> >> <---
> >> < include/linux/usb/dwc_otg.h |  274
> >>
> >> [Tirumala Marri] I am not sure how to separate your changes. But we need
> >> More time as our initial patches are still pending.
> >
> > pending where?  Have you submitted them for inclusion?
> >
> 
> 13 times in fact.  Each time, more comments and fixes need.  Par for
> the course with a vendor driver, but in this case Pratyush thought the
> APM guys had let it die and tried to carry it forward.  I guess APM
> has been sitting on it for more than 4 months now.
> 
> Anyway, hope that clears up some of the confusion.

It does, thanks.

greg k-h
