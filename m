Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 71801DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:17:51 +1100 (EST)
Date: Wed, 14 Mar 2007 17:17:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
In-Reply-To: <20070314160258.GK4095@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Al,

On Wed, 14 Mar 2007, Al Viro wrote:
> On Wed, Mar 14, 2007 at 10:50:16AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 14 Mar 2007, Al Viro wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > NAK
> 
> Lovely...  Consider that one withdrawn, please.  FWIW, if we leave it bool
> (and flip_ctl mess alone would make a good reason for that) we probably want
> to have it depend on FB=y

What's the advantage of making FB_PS3 depend on FB=y vs. plain FB?
In both cases it can be enabled if FB=y only, right? Or am I missing something?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
