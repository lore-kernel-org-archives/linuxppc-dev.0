Return-Path: <sshtylyov@mvista.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73F5EB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:59:16 +1000 (EST)
Received: by wwg9 with SMTP id 9so5820504wwg.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 05:59:11 -0700 (PDT)
Message-ID: <4E5CDE24.1000705@ru.mvista.com>
Date: Tue, 30 Aug 2011 16:57:08 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 12/14] include/linux/usb/gadget.h : include
	<linux/device.h> for successful compilation
References: <cover.1314704557.git.pratyush.anand@st.com>
	<171f829cad0bfa86b79ae74e9c6c9ae4eefb2738.1314704558.git.pratyush.anand@st.com>
In-Reply-To: <171f829cad0bfa86b79ae74e9c6c9ae4eefb2738.1314704558.git.pratyush.anand@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello.

On 08/30/2011 03:57 PM, Pratyush Anand wrote:

> gadget.h uses struct device, which has been declared in linux/device.h. So it
> must be included.

> Signed-off-by: Pratyush Anand<pratyush.anand@st.com>
> ---
>   include/linux/usb/gadget.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 006412c..32f7b69 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -16,6 +16,7 @@
>   #define __LINUX_USB_GADGET_H
>
>   #include<linux/slab.h>
> +#include<linux/device.h>

    On what tree are you basing? There have been patches accepted in v3.1-rc1, 
which added a bunch of #include's to that file (including <linux/device.h>).

WBR, Sergei
