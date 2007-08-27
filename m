Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 75848DDFDF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:24:41 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so2511498wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 07:24:40 -0700 (PDT)
Message-ID: <fa686aa40708270724r3d1a3bd3jccbc161475e93343@mail.gmail.com>
Date: Mon, 27 Aug 2007 08:24:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <12347049.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12347049.post@talk.nabble.com>
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

On 8/27/07, Mirek23 <miroslaw.dach@psi.ch> wrote:
> 4. I am trying to start the kernel
>
> => bootm 0x1000000
>
> ## Booting image at 01000000 ...
> Image Name:   Linux-2.6.21-rc6
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    991375 Bytes = 968.1 kB
> Load Address: 00000000
> Entry Point:  00000000
> Verifying Checksum ... OK
> Uncompressing Kernel Image ... OK

Have you looked in __log_buf for kernel messages?
What does your u-boot env look like?
Do you have 'console=ttyUL0' or 'console=ttyS0' in the kernel command line?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
