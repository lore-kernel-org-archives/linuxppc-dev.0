Subject: Re: VGA out on ibook2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Paulo Abreu <paulotex@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org, guile@mac.com
In-Reply-To: <20011012083602.385%96000@smtp.netc.pt>
References: <200110120459.XAA10187@lists.linuxppc.org>
	<20011012083602.385%96000@smtp.netc.pt>
Content-Type: text/plain; charset=ISO-8859-1
Date: 13 Oct 2001 13:05:24 +0200
Message-Id: <1002971124.7091.1880.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2001-10-12 at 09:36, Paulo Abreu wrote:
>
> Linux PPC Developer Digest wrote:
> >Hi
> >	I'm trying to use the external VGA connector on an ibook2 (the white
> >one) with the benh utility m3mirror and, after turning crt on, the
> >screen on the monitor looks "wavy" and unusable.
> >	Anybody could guide me to solve this problem?
>
> Same problem here. If I include the crt:1 option in the kernel booting
> options, the waves dissapear and the console looks good, but the X
> colors are all wrong. Looks like the crt is in 8bpp while X and the lcd
> are in 16bpp. Tried this with 2.4.10-ben0.

Do you use Option "UseFBDev" in X?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
