Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2E6BCDDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 05:09:42 +1100 (EST)
Date: Wed, 14 Mar 2007 19:09:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
In-Reply-To: <20070314175936.GM4095@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0703141907290.28462@pademelon.sonytel.be>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
	<20070314170720.GL4095@ftp.linux.org.uk>
	<Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
	<20070314175936.GM4095@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Mar 2007, Al Viro wrote:
> On Wed, Mar 14, 2007 at 10:30:31AM -0700, Linus Torvalds wrote:
> > Maybe not "bool" vs "mbool", but it might be nice to have
> > 
> > 	bool FB_PS3
> > 		depends strictly on FB
> > 
> > ie a "depends strictly" refuses to upgrade a bool dependency from "m" to 
> > "y", while a regular depends allows it.
> > 
> > Or something.. The "depends strictly on X" thing would really be just a 
> > mental shorthand for "depends on (X)=y" (it's actually longer to type, but 
> > I think it's a bit more intuitive, thus "mental shortcut").
> 
> There's a fun side question, though: what should allmodconfig do?  FB=m,
> FB_PS3=n?  Or FB=y, FB_PS3=y?

>From `make help':
| New config selecting modules when possible

FB can be a module, so FB=m, FB_PS3=n.

It doesn't say anything about things that can't be modules :-)

But I agree the chances of getting a system that doesn't work increase...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
