Return-Path: <akpm@linux-foundation.org>
Date: Mon, 15 Oct 2007 14:43:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 12/13] fb: Move and rename extern declaration for
	global_mode_option
Message-Id: <20071015144340.167d1cda.akpm@linux-foundation.org>
In-Reply-To: <20071012145130.867069000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
	<20071012145130.867069000@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org,
	adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Oct 2007 16:51:04 +0200
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> -    if (mode_option || (mode_option = global_mode_option)) {
> +    if (mode_option || (mode_option = fb_mode_option)) {

I guess that equals-which-looks-like-it-should-be-equals-equals really
is intended to be an assignment?

I guess.  After staring at it for a while.  It's a pretty obnoxious way
of coding it, especially in kernel context where such things are unexpected...
