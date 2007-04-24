Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 92CDADDF60
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:55:51 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so145672ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 06:55:49 -0700 (PDT)
Message-ID: <528646bc0704240655n6c80f2ffnc8f0c328149b3c15@mail.gmail.com>
Date: Tue, 24 Apr 2007 07:55:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: 2.6 Kernel ,
	Xilinx Virtex and PPC 405 On chip memory controllers ( DSOCM and
	ISOCM )
In-Reply-To: <BAY115-W4BC24E5FE6C3B6EB88C72B24A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W4BC24E5FE6C3B6EB88C72B24A0@phx.gbl>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/24/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
> suppose that in my base system I have included 8kbytes of memory for DS OCM and 8K for IS OCM,
> I have generated the proper xparameters.h and copied it into kernel
>
> Now I want to know if kernel will use this portion of memory during it's operation?
> Does this increase performance?

No, it won't use that memory as general purpose RAM.  You can make use
of it in device drivers (ie. for DMA space), but you'll need to write
the code to support it.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
