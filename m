Message-ID: <10183-36126@sneakemail.com>
Date: Sun, 21 Mar 2004 18:00:13 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SystemACE, but I'm not a V2Pro
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm successfully using the existing System ACE adapter driver
to mount my compact flash devices, and that's great. But I'm
getting some baggage I don't want. Specifically, in adapter.c
the xsysace_init function replaces the ppc_md.restart function
with xsysace_restart, which breaks reboot on my PPC405GPr based
board.

The brute force method is for me to #ifdef out that bit of
code with something like "#ifndef CONFIG_JSE" (my board is
a JSE board) but that seems klunky.

It seems to me there may be others who have SystemACE boards
without V2Pro chips. Would it be safe and reasonable for me
to use the CONFIG_VIRTEX_II_PRO config define to ifdef that
bit of code *in*?

(I'm asking because I'd like to integrate my board support
into the main tree someday, so I want a generally clean patch.)

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
