Subject: Re: [patch] ignore trackpad/mouse while typing
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Till Straumann <Till.Straumann@TU-Berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org, vojtech@suse.cz
In-Reply-To: <3DE6C428.5000403@TU-Berlin.de>
References: <3DE6C428.5000403@TU-Berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1038880026.17922.208.camel@thor>
Mime-Version: 1.0
Date: 03 Dec 2002 02:47:06 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fre, 2002-11-29 at 02:34, Till Straumann wrote:

> + 		if ( jiffies - mouse_holdoff_last_jiffie < mouse_holdoff_jiffies )
> + 			return;
> + 		/* Note: we could lose mouse events when the jiffie counter rolls over... */

I think the difference is always correct.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
