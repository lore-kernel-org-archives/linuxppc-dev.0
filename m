Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 86C2BDDF54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:53:30 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so2521574wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 07:53:29 -0700 (PDT)
Message-ID: <fa686aa40708270753u1411796fv698d3b39ee908599@mail.gmail.com>
Date: Mon, 27 Aug 2007 08:53:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708271634110.30948-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708270724r3d1a3bd3jccbc161475e93343@mail.gmail.com>
	<Pine.LNX.4.44.0708271634110.30948-100000@slslc02.psi.ch>
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

On 8/27/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Hi Grant,
>
>         Thank you for your response.
>
> My u-boot bootargs is set to:
> console=ttyUL0,9600 root=/dev/nfs rw nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp  ip=::::virtex4-mirek:eth0:dhcp panic=1

Drop the ',9600'.  It's irrelevant for uartlite.

>
> where I can find __log_buf for kernel messages?

Search for __log_buf in System.map (in the kernel source tree).  Use a
debugger to look at the memory.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
