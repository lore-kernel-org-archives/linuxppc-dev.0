Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org,
	Herbert Duerr <duerr@sun.com>
In-Reply-To: <1002814351.12609.408.camel@pismo>
In-Reply-To: <200110111541.f9BFfFf02772@ashley.ivey.uwo.ca>
References: <200110111541.f9BFfFf02772@ashley.ivey.uwo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Date: 11 Oct 2001 18:33:26 +0200
Message-Id: <1002818006.12609.941.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2001-10-11 at 17:37, Kevin Hendricks wrote:

> > So what's in CVS only works for fbdev, Kevin's patch is needed for
> > r128?
>
> I went and used cvsweb on Xfree86.org to see what keithp actually
> committed.
>
> The bug I found was actually *already* fixed by XF4 guys  soon after
> XF410 was released (they simply removed the || !xFormat in the "if")
> (given the dates on the Xrender.c changes).
>
> So all keithp had to add was the code to check to make sure xData
> malloced okay (i.e put back in || !xData in the "if").
>
> So what is in cvs head right now for this code snippet turns out to be
> exactly what my  patch will do for XF 4.1.0.
>
> I assume the r128 versus framebuffer issue was only due to random memory
> being tested so the results were/are random.
>
> The patch is needed for all 4.1.0 respins since the bug only exists in
> 4.1.0 but anything based on cvs recently should be okay as is.

The fix is only in the trunk, not the 4.1 branch?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
