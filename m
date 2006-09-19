Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 9FE3567B67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 00:17:18 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so460039ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 07:17:16 -0700 (PDT)
Message-ID: <528646bc0609190717u1c7cd349m7e08e5bafd341c38@mail.gmail.com>
Date: Tue, 19 Sep 2006 08:17:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <87hcz4z47p.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<87hcz4z47p.fsf@sleipner.barco.com>
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

On 9/19/06, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:
> GL> If we reject the Xilinx driver code, then we either have to do
> GL> without Xilinx support in mainline, or we need to write new
> GL> drivers that address the above issues (support multiple IP
> GL> versions, etc).  The Xilinx support in mainline right now does not
> GL> use any Xilinx code.  (Xilinx PIC and UART).
>
> I think the best option is to simply forget about the Xilinx code,
> see the FPGAs as any other PPC system and write normal device drivers
> for it. Your platform bus stuff and my (to-be-mainlined) uartlite
> driver is a first step in this direction..

Too bad platform bus is sooo last year.  :p

Time to hack device trees.
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
