Message-ID: <3B688167.9010906@hadess.net>
Date: Wed, 01 Aug 2001 23:23:35 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	"Joseph P. Garcia" <jpgarcia@execpc.com>
Subject: special adb buttons don't survive sleep
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Joseph's code for the special adb buttons doesn't survive sleep, the
event device just isn't present anymore when coming back from sleep. All
the other event devices are present (/dev/input/eventX).

Franz, any tips ?

Cheers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
