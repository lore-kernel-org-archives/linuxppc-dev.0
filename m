Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 1FE63DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 23:21:31 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so341746wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 06:21:29 -0700 (PDT)
Message-ID: <fa686aa40708300621n1e60c643j957c73d997a7d262@mail.gmail.com>
Date: Thu, 30 Aug 2007 07:21:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708300923140.12294-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708290817k897f8c2y5fdf12e5a48cc0ac@mail.gmail.com>
	<Pine.LNX.4.44.0708300923140.12294-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/30/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
>
> When I try to start zImage.elf with bootelf command the system hangs during
> uncompressing.
> When I try to start uImage with bootm command the image is uncompressed
> but it does not start properly.

Ugh, I'm stumped.  Sorry.  I'd spend some more quality time with your
debugger to trace the exact boot path.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
