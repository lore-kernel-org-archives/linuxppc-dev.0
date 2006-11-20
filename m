Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17762.11247.302674.175475@cargo.ozlabs.ibm.com>
Date: Tue, 21 Nov 2006 09:27:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] setup_kcore(): Fix incorrect function name in panic()
	call.
In-Reply-To: <Pine.LNX.4.62.0611170620240.16998@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
	<200611171458.11245.jk@ozlabs.org>
	<Pine.LNX.4.62.0611170506510.16998@pademelon.sonytel.be>
	<Pine.LNX.4.62.0611170620240.16998@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven writes:

> On Fri, 17 Nov 2006, Geert Uytterhoeven wrote:
> > On Fri, 17 Nov 2006, Jeremy Kerr wrote:
> > > 
> > > > -			panic("mem_init: kmalloc failed\n");
> > > > +			panic("setup_kcore: kmalloc failed\n");
> > > 
> > > How about:
> > > 	
> > > 	panic("%s: kmalloc_failed\n", __FUNCTION__);
> > > 
> > > To prevent this happening again?
> > 
> > You're right, thanks for the suggestion!
> 
> Updated patch below:

Grumble.

Please don't send patches that you want to go upstream with a subject
starting with "Re:" and a whole pile of stuff preceding the patch
description.  Do it like Andrew Morton describes in:

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Regards,
Paul.
