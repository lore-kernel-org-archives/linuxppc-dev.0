Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id D41E0DDF77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 16:28:24 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so601726ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 23:28:23 -0700 (PDT)
Message-ID: <528646bc0704262328n8e653dfya55dd3c5ad3dd67c@mail.gmail.com>
Date: Fri, 27 Apr 2007 00:28:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [RFC] add 8-bit bus support to the Xilinx SystemACE device driver
	+ minor clean-ups
In-Reply-To: <4627B5AE.5060109@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176600194262-git-send-email-grant.likely@secretlab.ca>
	<4627B5AE.5060109@ru.mvista.com>
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

On 4/19/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Hello,
>
> The attached patch should be applied on top of the SystemACE device
> driver patch by Grant.

I just realized I never replyed to you on this one.  Sorry!

Thanks for the patch.  I'm getting the driver ready for mainline
submission now and I'll make sure 8 bit support is included.  I'll
also need your help with some more testing as I'm doing a fair bit of
rework on the bus attachment and error handling.

Thanks again,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
