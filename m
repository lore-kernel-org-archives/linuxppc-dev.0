Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8F90B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:56:00 +1000 (EST)
Received: by yib12 with SMTP id 12so2103081yib.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 04:55:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E60BEB9.4020200@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<73a8a4be221e3bc0404da22473913e9a846ee0df.1314704557.git.pratyush.anand@st.com>
	<20110831071929.GA9353@linutronix.de>
	<CAHM4w1nwyCxJYyPxJn=yXmcD+cAMY4txorrgfKHdp-FGDZ7BKg@mail.gmail.com>
	<4E60BEB9.4020200@linutronix.de>
Date: Fri, 2 Sep 2011 17:25:57 +0530
Message-ID: <CAHM4w1ms=T+8sKe+spb6kNxpw_VC32-KSwne9w9E0kgyUMQfRw@mail.gmail.com>
Subject: Re: [PATCH 03/14] dwc/otg: Add driver framework
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

On Fri, Sep 2, 2011 at 5:02 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 09/02/2011 01:17 PM, Pratyush Anand wrote:
>>>
>>> oh boy, oh boy. This is a huge number of module parameters. Do you
>>> actually expect someone setting all of them on modprobe? And if udev is
>>> faster you rmmod and modpobe again, right? The clever ones would enter
>>> it somewhere in modprobe.conf or so. Anyway. Since you have
>>> already device tree bindings and I assume you are using them, why not
>>> move all this parameters into the device and remove _all_ module
>>> parameters?
>>
>> In my case, I am passing necessary parameters from platform_data.
>> I do not use module param.
>
> From what I can see in
> =A0http://permalink.gmane.org/gmane.linux.ports.arm.kernel/76267
>
> is that it is being worked on DT-support for SPEAr. So I think it
> would be better to grab this information from the device tree if
> available (and keep the standard value otherwise) instead of starting
> doing the platform_data thingy.

will get the knowledge about device tree and will explore this option.

Regards
Pratyush

>
> Sebastian
>
