Subject: Re: Sync palm on 2.4.x
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3C177F48.80DD694@rd.francetelecom.com>
References: <3C177F48.80DD694@rd.francetelecom.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 12 Dec 2001 18:43:15 +0100
Message-Id: <1008178995.8901.13.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2001-12-12 at 17:01, FASSINO Jean-Philippe wrote:

> I can't sync palm using irda on PowerBook G3 with kernel 2.4.

Are you limiting speed to 57600 bps in /proc/sys/net/irda/max_baud_rate?
It doesn't work with higher speeds yet.

You also need a very recent kernel for this...


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
