Date: Thu, 9 Aug 2001 10:42:50 +0200
From: Olaf Hering <olh@suse.de>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: TiBook powers off on boot
Message-ID: <20010809104250.B25806@suse.de>
References: <200108090601.IAA00745@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108090601.IAA00745@piglet.grunz.lu>; from mlan@cpu.lu on Thu, Aug 09, 2001 at 08:01:43AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 09, Michel Lanners wrote:

> With BenH's latest tree (rsync from two or three days ago), my TiBook
> powers off on boot. The last thing I see on display is the firewire
> thing intializing; after that it just goes 'poof' and it's off.
>
> Also, when this happens, it seems the hardware clock is reset. Next
> boot, it's at 1904...
>
> >From both descriptions I'd say soething scribbles over the PMU memory
> area. Anybody know more?

Firewire is broken since 2.4.7-pre8, so turn it off until it is fixed ;)
If you need a working firewire tree:
/mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/sleep/


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
