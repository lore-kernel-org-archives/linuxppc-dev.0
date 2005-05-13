Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 15082679F4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 23:03:02 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4DD7kXR015055
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 16:07:46 +0300 (EEST)
Message-ID: <4284A19A.7010901@intracom.gr>
Date: Fri, 13 May 2005 15:46:18 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marco Schramel <Schramel.Linux@go.bartec.de>
References: <200505131433.23307.Schramel.Linux@go.bartec.de>
In-Reply-To: <200505131433.23307.Schramel.Linux@go.bartec.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: insmod problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Schramel wrote:
> Hi,
> 
> we use a custom mpc8270 system. Everything works fine.
> Now i have to handle some float values in a device driver. If i insert the compiled module my target prints out 
> 
> insmod: unresolved symbol __addsf3
> insmod: unresolved symbol __floatsisf
> 
> Are there any missing libraries ?
> 
> Any other ideas?
> 
> Best regards
> 
> Marco
> 
> 

You're using floating arithmetic in the kernel.

That's not supported.

Regards

Pantelis
