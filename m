From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: <linux-fbdev-devel@lists.sourceforge.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Scaling registers on r128
Date: Mon, 12 Nov 2001 14:16:50 +0100
Message-Id: <20011112131650.6754@smtp.adsl.oleane.com>
In-Reply-To: <3BEF952D.9000306@humboldt.co.uk>
References: <3BEF952D.9000306@humboldt.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This patch to aty128fb is experimental, and intended for the brave.
>
>The attached patch turns on the panel scaling registers of the R128.
>I've run this on my iBook2, and I've been able to display 640x480 and
>800x600 modes on the panel successfully.
>
>The panel sizes are currently hardwired on the iBook. This code will
>benefit greatly from a reliable means to find the panel size.
>
>This has revealed problems in the X server: if the XF86Config-4
>specifies 800x600 and the current console is in 1024x768, the display is
>broken. This looks like a generic problem in fbdevhw based Xservers, as
>I saw something similar on 69030.

great. I'm working on some way to probe the panel type on those
machines as it doesn't seem to follow any standard. Once don

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
