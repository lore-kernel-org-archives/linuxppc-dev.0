Message-ID: <3B6318C5.3080305@hadess.net>
Date: Sat, 28 Jul 2001 20:55:49 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: on_ac_power replacement
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just wrote a little perl script that mimicks the behaviour of the
on_ac_power from the apmd distribution.
It requires a new kernel with /proc/pmu directory, and is needed by
anacron (check /etc/init.d/anacron)

Michael, could you add it to the pmud-utils ?

http://hadess.net/files/ppc/on_ac_power

Cheers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
