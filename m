Message-ID: <39896582.F51504B4@amulet.co.jp>
Date: Thu, 03 Aug 2000 21:28:50 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: initscript logging (was rtc again...)
References: <200008030957.KAA17120@hyperion.valhalla.net> <39895E55.E7659D16@wanadoo.fr>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
>
> But then I admit don't understand what the timestamps in log/messages
> mean. They certainly don't indicate the time when the actions happened.
> The kernel messages have later timestamps than the rc.sysinit actions.
> And in 2.4.x the order of these messages is completely different from
> the one in 2.2.x.

Actually I was just reading about that at
http://www.redhat.com/knowledgebase/initscripts. Apparently all the messages
are buffered by a fake syslogd until root is remounted rw, at which point
the syslog buffer, the kernel dmesg buffer, and additional init script
activity is all send to the real syslogd and klogd (and logged to disk) at
the same time. Understandably, things get mixed up a little.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
