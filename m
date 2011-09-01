Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56073B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 10:18:17 +1000 (EST)
Received: by vws20 with SMTP id 20so1097383vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 17:18:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831223633.GC27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<9183dc7afa5b8cde400e9f37f5679d4f@mail.gmail.com>
	<20110831223633.GC27818@kroah.com>
Date: Wed, 31 Aug 2011 20:18:12 -0400
Message-ID: <CA+5PVA569eWwYvU9Ghs6yGNimTPDX0+fbmouMV2yuxjyA7J4+g@mail.gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
From: Josh Boyer <jwboyer@gmail.com>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, Aug 31, 2011 at 6:36 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 30, 2011 at 08:29:21AM -0700, Tirumala Marri wrote:
>> <-----Original Message-----
>> <From: Pratyush Anand [mailto:pratyush.anand@st.com]
>> <Sent: Tuesday, August 30, 2011 4:58 AM
>> <To: linux-usb@vger.kernel.org
>> <Cc: tmarri@apm.com; linuxppc-dev@lists.ozlabs.org; fchen@apm.com;
>> <mmiesfeld@apm.com; shiraz.hashim@st.com; deepak.sikri@st.com;
>> <vipulkumar.samar@st.com; rajeev-dlh.kumar@st.com; vipin.kumar@st.com;
>> <bhupesh.sharma@st.com; viresh.kumar@st.com; Amit.VIRDI@st.com; Pratyush
>> <Anand
>> <Subject: [PATCH 02/14] dwc/otg: Structure declaration for shared data
>> <
>> <There are some DWC OTG parameters which might be passed by a platform.
>> <Declaration for structure of those parameters have been provided in thi=
s
>> <include file.
>> <
>> <Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> <---
>> < include/linux/usb/dwc_otg.h | =A0274
>>
>> [Tirumala Marri] I am not sure how to separate your changes. But we need
>> More time as our initial patches are still pending.
>
> pending where? =A0Have you submitted them for inclusion?
>

13 times in fact.  Each time, more comments and fixes need.  Par for
the course with a vendor driver, but in this case Pratyush thought the
APM guys had let it die and tried to carry it forward.  I guess APM
has been sitting on it for more than 4 months now.

Anyway, hope that clears up some of the confusion.

josh
