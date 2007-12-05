Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 7FEBFDDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 05:16:52 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1026679anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Dec 2007 10:16:51 -0800 (PST)
Message-ID: <fa686aa40712051016tb64bc52ked782bed80a5aeb5@mail.gmail.com>
Date: Wed, 5 Dec 2007 11:16:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: khollan <khollan@daktronics.com>
Subject: Re: Uboot and ML410
In-Reply-To: <14177109.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <14177109.post@talk.nabble.com>
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

On 12/5/07, khollan <khollan@daktronics.com> wrote:
>
> Hi
>
> Is there a patch to include support for the ml410 in the Main git tree of
> u-boot?  I tried compiling Xilinx's tree but it seems it won't compile
> correctly with my version of make (3.81).

I don't think there is.

>  Also is there any support for the
> Hard TEMAC in u-boot?  I tried looking for both of these questions but a lot
> of the threads were unanswered questions.  Thanks for your help

No, unfortunately nobody has got a hard TEMAC driver into u-boot mainline.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
