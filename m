Message-ID: <40B73451.4080001@intracom.gr>
Date: Fri, 28 May 2004 15:45:05 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Ho <DavidHo@nanometrics.ca>
Cc: Dan Malek <dan@embeddededge.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: RTC no longer exist on the 866/87x/88x
References: <OFA7FE93B3.1BAFEB05-ON85256EA2.0044EB60-85256EA2.00457969@nanometrics.ca>
In-Reply-To: <OFA7FE93B3.1BAFEB05-ON85256EA2.0044EB60-85256EA2.00457969@nanometrics.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ho wrote:

>
>
>
>Hi 8xx gurus,
>
>I just noticed the RTC is no longer documented/tested/supported on the
>duet.  How does this impact the current 2.4 8xx tree?
>
>I know the /dev/rtc still uses RTC on the processor, it appears to work
>fine, but I wouldn't bet my life on it for production units.
>
I believe there's a problem with increased power consumption
by the RTC so that's why Motorola removed it from the docs.

>
>How about the kernel's timing service and scheduling, does it use the
>timebase register instead?  Are these services effected at all?
>
>
Don't worry, they're not affected at all.

>Thanks a lot,
>
>David Ho
>Nanometrics Inc.
>
>
>
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
