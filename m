Message-ID: <3EC03975.6070002@embeddededge.com>
Date: Mon, 12 May 2003 20:16:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
References: <20030512211733.B489EC6092@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

> All feedback welcome.

I agree.  I've never liked calling rtc update functions from the timer
interrupt.  This is significant overhead that should be avoided in
the timer interrupt.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
