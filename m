Message-ID: <3BC58640.ED96765F@iiic.ethz.ch>
Date: Thu, 11 Oct 2001 13:45:04 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.linuxppc.org, Herbert Duerr <duerr@sun.com>,
	Olaf Hering <olh@suse.de>, kevin.hendricks@sympatico.ca
Subject: Re: Fwd: Re: bug in XFree86 4.1.0 with Rage 128 driver?
References: <20011011025115.HNCD13446.tomts8-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

> The bug was in XF 4.1.0 in Xrender.c not in OpenOffice
>
> The patch is attached.  They (XF4 guys) simply missed changing a variable
> name and ended up using random garbage in an "if"

Why does it work with the fbdev driver then?


> Michel will you see that this makes it into the next XF 4.X release for us.

I don't feel qualified to do that. Xpert@XFree86.Org is a mailing list which
the author of this code and other very competent XFree86 hackers read, or if
you're absolutely sure the fix is correct, please submit it to
fixes@XFree86.Org .


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
