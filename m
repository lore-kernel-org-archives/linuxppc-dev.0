Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id C28C067B69
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 08:57:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so103372ugc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 15:57:40 -0700 (PDT)
Message-ID: <528646bc0609141557s4c126f4fh61f1ca8a21a628ad@mail.gmail.com>
Date: Thu, 14 Sep 2006 16:57:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Keith J Outwater" <kjoutwater@raytheon.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <OF4E2E74F4.771A25A6-ON072571E9.00554898-072571E9.0056BF13@mck.us.ray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<OF4E2E74F4.771A25A6-ON072571E9.00554898-072571E9.0056BF13@mck.us.ray.com>
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

On 9/14/06, Keith J Outwater <kjoutwater@raytheon.com> wrote:
> >
> > So what direction do we (as the community) want to go for supporting
> > Xilinx IP in the Linux kernel?
>
> I don't know about anyone else, but running Linux on Virtex FPGAs is
> something I simply have to be able to do.  With or without Xilinx
> drivers, I think the kernel needs to support Xilinx hardware.

ditto

>
> >
> > If we reject the Xilinx driver code, then we either have to do without
> > Xilinx support in mainline, or we need to write new drivers that
> > address the above issues (support multiple IP versions, etc).  The
> > Xilinx support in mainline right now does not use any Xilinx code.
> > (Xilinx PIC and UART).
> >
> > Thoughts?
>
> As painful as it may be, maybe we just write drivers from scratch and
> try to track changes in the IP.

That's kind of the direction I'm leaning too.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
