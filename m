Subject: Re: Scaling registers on r128
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org,
	linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <3BEF952D.9000306@humboldt.co.uk>
References: <3BEF952D.9000306@humboldt.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Date: 22 Nov 2001 02:42:53 +0100
Message-Id: <1006393373.24727.23.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2001-11-12 at 10:23, Adrian Cox wrote:

> The attached patch turns on the panel scaling registers of the R128.
> I've run this on my iBook2, and I've been able to display 640x480 and
> 800x600 modes on the panel successfully.

So have I, but they both flicker noticeably, and there is corruption in
X with the server built-in modes, but not with modes generated with
fbset -x. Both effects are only slightly noticeable in 800x600 but more
so in 640x480.

Nice work though!


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
