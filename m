Date: Sun, 2 Dec 2001 19:42:25 +0100 (CET)
From: Haavard Kvaalen <havardk@netcom.no>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bryce McKinlay <bryce@waitaki.otago.ac.nz>,
	<linuxppc-dev@lists.linuxppc.org>,
	Jeff Koftinoff <jeffk@jdkoftinoff.com>
Subject: Re: Byte order in sound drivers
In-Reply-To: <20011202095651.24942@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0112021935520.3537-100000@hakva-2.student.nlh.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2 Dec 2001, Benjamin Herrenschmidt wrote:

> Most recent machines don't do HW byteswap, and so accept only
> big-endian samples. The way this is implemented in our driver
> currently is a bit weird though, the setformat ioctl won't fail when
> trying to set an LE format, but it will set the equivalent BE format.

This is the correct way to tell the application what format the driver can
handle, and XMMS depends on this to be working.

--
Håvard Kvålen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
