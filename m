Return-Path: <frannk_m1@yahoo.com>
Received: from web32210.mail.mud.yahoo.com (web32210.mail.mud.yahoo.com
	[68.142.207.141]) by ozlabs.org (Postfix) with SMTP id E7A0867B24
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 14:54:36 +1000 (EST)
Message-ID: <20050427045434.7191.qmail@web32210.mail.mud.yahoo.com>
Date: Tue, 26 Apr 2005 21:54:34 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Garcia "Jérémie" <GARCIAJ@3il.fr>, linuxppc-dev@ozlabs.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Booting linux for 405EP --> mem_pieces_find( ) nightmare
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- Garcia Jérémie <GARCIAJ@3il.fr> wrote:
> Hi everybody,
> I'm tryin to adapt a linux LSP deom Montavista (the one for
> the 405EP evaluation board) to a proprietary hardware using a
> 405EP.
> Unfortunately, it is not as easy as I thought. Here is my
> problem:
> To load our linux image (zImage.treeboot), we use the "VxWorks
> bootrom" bootloader which download the image via tftp.
Why don't you do it the other way( use u-boot). I just replaced
a vxWorks rom with u-boot and now I can happily boot vxWorks or
Linux on an 8260 based board... 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
