In-Reply-To: <40B711A6.1080603@intracom.gr>
Subject: RTC no longer exist on the 866/87x/88x
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Message-ID: <OFA7FE93B3.1BAFEB05-ON85256EA2.0044EB60-85256EA2.00457969@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Fri, 28 May 2004 08:38:50 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi 8xx gurus,

I just noticed the RTC is no longer documented/tested/supported on the
duet.  How does this impact the current 2.4 8xx tree?

I know the /dev/rtc still uses RTC on the processor, it appears to work
fine, but I wouldn't bet my life on it for production units.

How about the kernel's timing service and scheduling, does it use the
timebase register instead?  Are these services effected at all?

Thanks a lot,

David Ho
Nanometrics Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
