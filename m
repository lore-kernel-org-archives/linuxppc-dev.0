Message-ID: <40B711A6.1080603@intracom.gr>
Date: Fri, 28 May 2004 13:17:10 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6-7-rc1 8xx - No go
References: <40B6FAFB.8020803@intracom.gr>
In-Reply-To: <40B6FAFB.8020803@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

> Hi there.
>
> I'm reporting that my tree, after updating from 2.6.6 -> 2.6.7-rc1
> does not work any more.
>
> Currently investigating why.
>
> Regards
>
> Pantelis
>
>
Update; for some reason the problem seems to be that page faults
are incredibly slow.

Starting a dummy init after a minute it manages to start and operate
correctly.

I suspect a terribly slow page fault.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
