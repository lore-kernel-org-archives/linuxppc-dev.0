Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id E69FCDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 08:51:06 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i21so263153wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 15:51:06 -0700 (PDT)
Message-ID: <fa686aa40707121551i7b123818i94423c386f58a5bb@mail.gmail.com>
Date: Thu, 12 Jul 2007 16:51:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: XSysAce driver cant mount DOS part
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17209@hsv1dafpew02.das.gov.sanm.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707121116l1d76078aq82926eb861720474@mail.gmail.com>
	<939D37AEB47F1F49B88FAB6599B6023501A17206@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707121206n7e75e770q742adb3659f35e79@mail.gmail.com>
	<939D37AEB47F1F49B88FAB6599B6023501A17209@hsv1dafpew02.das.gov.sanm.corp>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/12/07, Robertson, Joseph M. <joseph.robertson@sanmina-sci.com> wrote:
> Hi,
>
>  Ok this is surely enough to drive you nuts, but all I get is an error.
>  How the heck do you debug patch?  All I get is this.
>
> root@tocnet_ws_9:/mnt/public2/ecau/src/linux/linux-2.6.17.1#
> patch -p1 -un  -i xsys.patch
>  patch unexpectedly ends in middle of line
>  patch: **** Only garbage was found in the patch input.

The Gmane web view mangles patches.  You can use an NNTP client to
talk to gmane to get them without mangling.

But to keep things simple, I'll just email you the patch.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
