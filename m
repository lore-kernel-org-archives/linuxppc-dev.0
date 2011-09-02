Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9F60B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 23:00:05 +1000 (EST)
Subject: Re: [PATCH 14/14] arm/include/asm/io.h : added macros to
	read/write big/little endian register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pratyush Anand <pratyush.anand@gmail.com>
In-Reply-To: <CAHM4w1k56SgXXvDm0f8-P_LOsmYgG4_RjBVD3T9ws+BNk+U_+Q@mail.gmail.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
	<20110831073500.GB9353@linutronix.de>
	<CAHM4w1k56SgXXvDm0f8-P_LOsmYgG4_RjBVD3T9ws+BNk+U_+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Sep 2011 21:02:32 +1000
Message-ID: <1314961352.13112.2.camel@pasglop>
Mime-Version: 1.0
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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


> There can be some peripheral like dwc-otg, whose registers will be
> either in LE or in BE
> depending on the RTL configuration selected by a implementor.
> Software always expects a LE value when it will call "in_" and will
> provide a LE value when "out_".
> It expects beacuse , it wants to do same bit wise operation for both
> configurations.

Then these are the wrong accessors.

Cheers,
Ben.

> 
> 
> >>+
> >
> > Please split this patch out and get it accepterd by ARM community. USB
> > people won't merge this.
> >
> 
> Ok, will send it to ARM mailing list.
> 
> Regards
> Pratyush
> 
> > Sebastian
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
