Message-ID: <3BE6C6E5.7070505@mvista.com>
Date: Mon, 05 Nov 2001 12:05:41 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.14-pre7
References: <3BE2C0A5.7080707@elsoft.ch> <20011102092032.F26147@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:


> Shouldn't board_setup_rtc_access() do all of the RTC stuff,

Please try to coordinate your RTC stuff with Armin.  I don't have
enough knowledge of the details to discuss this, and it appears there
is a very standard way of working with the RTC, which is board
specific.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
