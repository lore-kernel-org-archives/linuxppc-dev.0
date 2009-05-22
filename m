Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id BBD3CDDFA2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 15:26:08 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so783253ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 22:26:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <601801.28414.qm@web94805.mail.in2.yahoo.com>
References: <601801.28414.qm@web94805.mail.in2.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 23:25:47 -0600
Message-ID: <fa686aa40905212225k2761f91ct3d857088b88cb7fa@mail.gmail.com>
Subject: Re: problem in registering the device while inserting the kernel
	module
To: patel rajendra <rdpatel55@yahoo.co.in>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 21, 2009 at 12:20 AM, patel rajendra <rdpatel55@yahoo.co.in> wrote:
> Hi Members of linuxppc,
>
> I'm working on XUPV2P board with Virtex II Pro FPGA device.
>
> I written a kernel module for LED device. I got that module run successfuly
> on ML403 board having Virtex 4 FPGA.I have not make any change in my source
> code for XUP board, because I don't feel any change is required.

What kernel version are you using?
Are you using arch/ppc or arch/powerpc?

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
