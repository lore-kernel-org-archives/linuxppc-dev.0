Message-ID: <3F6A903E.7080505@tataelxsi.co.in>
Date: Fri, 19 Sep 2003 10:42:30 +0530
From: Omanakuttan <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: Todd <to_dd@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fundamental driver question ??
References: <20030918171414.49505.qmail@web40413.mail.yahoo.com>
In-Reply-To: <20030918171414.49505.qmail@web40413.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Todd wrote:
 > When a module is driving multiple devices: does the
 > driver code itself have multiple instances, or is
Re-entrant.
Moreover the interrupt can can be shared, and based on the device file
opened, handling of other functions may differ in the driver.
HTH


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
