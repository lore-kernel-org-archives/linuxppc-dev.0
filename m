Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id B228BDDFCF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 00:20:08 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so171765rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 07:20:06 -0700 (PDT)
Date: Fri, 19 Sep 2008 10:19:11 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Subject: Re: Regarding select() on PPC
Message-ID: <20080919135053.GA3237@yoda.jdub.homelinux.org>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56DCC8@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56DCC8@insardxms01.ap.sony.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 07:00:07PM +0530, Sadashiiv, Halesh wrote:
>>For negetive value of n (first argument to select) select fails with
>EINVAL
>>error,
>>
>>But for the same when I tested for PowerPC it was giving EFAULT,
>>Its on 2.6.16 kernel.

2.6.16 is really old.  I tested your testcase on a 2.6.25 based kernel on
a ppc64 machine and it seemed to work fine.

josh
