Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFA71B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:32:24 +1000 (EST)
Message-ID: <4E60BEB9.4020200@linutronix.de>
Date: Fri, 02 Sep 2011 13:32:09 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 03/14] dwc/otg: Add driver framework
References: <cover.1314704557.git.pratyush.anand@st.com>	<73a8a4be221e3bc0404da22473913e9a846ee0df.1314704557.git.pratyush.anand@st.com>	<20110831071929.GA9353@linutronix.de>
	<CAHM4w1nwyCxJYyPxJn=yXmcD+cAMY4txorrgfKHdp-FGDZ7BKg@mail.gmail.com>
In-Reply-To: <CAHM4w1nwyCxJYyPxJn=yXmcD+cAMY4txorrgfKHdp-FGDZ7BKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 09/02/2011 01:17 PM, Pratyush Anand wrote:
>> oh boy, oh boy. This is a huge number of module parameters. Do you
>> actually expect someone setting all of them on modprobe? And if udev is
>> faster you rmmod and modpobe again, right? The clever ones would enter
>> it somewhere in modprobe.conf or so. Anyway. Since you have
>> already device tree bindings and I assume you are using them, why not
>> move all this parameters into the device and remove _all_ module
>> parameters?
>
> In my case, I am passing necessary parameters from platform_data.
> I do not use module param.

 From what I can see in
   http://permalink.gmane.org/gmane.linux.ports.arm.kernel/76267

is that it is being worked on DT-support for SPEAr. So I think it
would be better to grab this information from the device tree if
available (and keep the standard value otherwise) instead of starting
doing the platform_data thingy.

Sebastian
