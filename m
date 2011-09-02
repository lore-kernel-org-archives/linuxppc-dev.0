Return-Path: <pratyush.anand@gmail.com>
Received: from mail-pz0-f46.google.com (mail-pz0-f46.google.com
	[209.85.210.46]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6CDAB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:49:21 +1000 (EST)
Received: by pzk32 with SMTP id 32so5087207pzk.33
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 04:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831223604.GB27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d10bbf1498af371e41907fa07624456d981e56af.1314704557.git.pratyush.anand@st.com>
	<20110831223604.GB27818@kroah.com>
Date: Fri, 2 Sep 2011 17:19:17 +0530
Message-ID: <CAHM4w1npnX9ELf6AypR7+3D55qUw3Euz0dT_rb7UOj=1buuN+A@mail.gmail.com>
Subject: Re: [PATCH 02/14] dwc/otg: Structure declaration for shared data
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Sep 1, 2011 at 4:06 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 30, 2011 at 05:27:49PM +0530, Pratyush Anand wrote:
>> There are some DWC OTG parameters which might be passed by a platform.
>> Declaration for structure of those parameters have been provided in this
>> include file.
>>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> ---
>> =A0include/linux/usb/dwc_otg.h | =A0274 ++++++++++++++++++++++++++++++++=
+++++++++++
>> =A01 files changed, 274 insertions(+), 0 deletions(-)
>> =A0create mode 100644 include/linux/usb/dwc_otg.h
>>
>> diff --git a/include/linux/usb/dwc_otg.h b/include/linux/usb/dwc_otg.h
>
> Shouldn't this be in include/linux/platform/ instead?

do you mean linux/platform_data/?

seems better place.

Regards
Pratyush

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
