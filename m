Return-Path: <B04825@freescale.com>
Message-ID: <4DBF0DF1.6050207@freescale.com>
Date: Mon, 2 May 2011 15:02:57 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: Login prompt on a video console instead of serial port?
References: <4DBF065C.3030407@freescale.com>
	<BANLkTikWMksVsvs8KzjdiZfRR-2WGD0Ftw@mail.gmail.com>
In-Reply-To: <BANLkTikWMksVsvs8KzjdiZfRR-2WGD0Ftw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

McClintock Matthew-B29882 wrote:
> Don't you have to spawn a terminal on the framebuffer for the login?

I suppose, but I don't know how to do that.  And although that would technically
answer the question in the subject of this thread, I still would have *some*
boot output on the serial port.  It would be nice if I could get all of stdout
on the video display, and all of stdin from the serial port.

> Right now getty spawns the login on the serial port via /etc/inittab.
> Something similiar is probably needed for the framebuffer.

getty appears to work only with serial devices, since it insists on a baud rate
as one of the parameters.

-- 
Timur Tabi
Linux kernel developer at Freescale
