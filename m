Message-ID: <3B6F95B8.23D29946@iogram.ch>
Date: Tue, 07 Aug 2001 09:16:08 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <daenzer@iogram.ch>
Reply-To: daenzer@debian.org
MIME-Version: 1.0
To: R Shapiro <reshapiro@mediaone.net>
Cc: Olaf Hering <olh@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
References: <20010805200639.A14938@suse.de>
		<Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>
		<20010806100644.A6859@suse.de>
		<15214.33465.500189.767261@mediaone.net>
		<3B6E8B6E.BED87E1A@iogram.ch> <15215.13183.403767.392132@mediaone.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:
>
> Michel Dänzer writes:
>  > Wouldn't it have to be video=aty128fb:1280x1024-8@60
>
> Yep, that seems to be the required syntax.  At least it works with an
> unpatched 2.4.8-pre3-ben0 kernel.  Many thanks.

Cool.


>  > is the modedb even used on PPC yet?
>
> I don't know the answer to that one.

Yes you do. :) The fact that the above line works implies that modedb is used.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
