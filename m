Message-ID: <3E2F1920.9070702@embeddededge.com>
Date: Wed, 22 Jan 2003 17:20:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Shen Rong <rshen@udtech.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: wrong definition in cpm_8260.h?
References: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Yes, the CPM will set these flags, but will it also clear them if the
> buffer is not first/last in a frame? I think not.

It doesn't matter.  The flags are always going to be set.  Why bother
clearing them when you always set them?

> I know that the driver is designed to always set them so in practise it
> won't be problem. However this could change some day.

Well, when it changes we can change the code to set/clear the flags
according to the buffer management algorithm.


> yes I know, but I still think those flags should be included in the RX_STATS macro.

Why?  Like I said in the previous message, they aren't part of any network
status.  They are buffer control flags and need to properly indicate how the
buffers are managed, not cleared as part of network status.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
