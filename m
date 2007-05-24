Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 49BBADDE40
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 01:07:15 +1000 (EST)
Date: Thu, 24 May 2007 17:07:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: "Andrew J. Barr" <andrew.james.barr@gmail.com>
Subject: Re: [PPC] 2.6.22-rc2: badness at mm/slab.c:777
In-Reply-To: <20070524073745.29cffa4b@powerbook.oakcourt.dyndns.org>
Message-ID: <Pine.LNX.4.62.0705241706460.23480@pademelon.sonytel.be>
References: <20070524073745.29cffa4b@powerbook.oakcourt.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 May 2007, Andrew J. Barr wrote:
> - ------------[ cut here ]------------
> Badness at mm/slab.c:777
> Call Trace:
> [effd7d60] [c0008478] show_stack+0x50/0x184 (unreliable)
> [effd7d80] [c00fc948] report_bug+0x84/0xc8
> [effd7d90] [c0228af4] __kprobes_text_start+0x11c/0x4f0
> [effd7da0] [c0010bc8] ret_from_except_full+0x0/0x4c
> - --- Exception: 700 at __kmalloc+0x28/0xe8
>     LR = __kzalloc+0x18/0x44
> [effd7e60] [c0198cc0] usb_get_descriptor+0x7c/0xc4 (unreliable)
> [effd7e70] [c006ab14] __kzalloc+0x18/0x44
> [effd7e90] [c019b84c] usb_get_configuration+0x7e0/0xb28
> [effd7f40] [c019368c] usb_new_device+0x24/0x100
> [effd7f60] [c0194630] hub_thread+0x844/0xc54
> [effd7fd0] [c0042b60] kthread+0x4c/0x88
> [effd7ff0] [c0011468] kernel_thread+0x44/0x60
> 
> Occurs during bootup on a Powerbook5,7 (PowerBook G4 17" post-Feb05)
> 
> dmesg and .config attached.

I'm seeing it too on PS3 when hitting CTRL-ALT-DEL.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
