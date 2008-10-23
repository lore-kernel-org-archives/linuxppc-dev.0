Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep28-int.chello.at (viefep28-int.chello.at [62.179.121.48])
	by ozlabs.org (Postfix) with ESMTP id 4A0B2DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 21:21:14 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problem while make menuconfig
Date: Thu, 23 Oct 2008 12:20:57 +0200
References: <CE652BC92C01E645A7AD3BCEF5CDD86B02FCBDBE@NOIMEX01.barco.com>
In-Reply-To: <CE652BC92C01E645A7AD3BCEF5CDD86B02FCBDBE@NOIMEX01.barco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810231220.59182.niklaus.giger@member.fsf.org>
Cc: "Dudeja, Ashish" <Ashish.Dudeja@barco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag 23 Oktober 2008 11.10:50 schrieb Dudeja, Ashish:
> Hello
>
> When I do make menuconfig I get following error :-
>
>
>
> "
>
> *** Unable to find the ncurses libraries or the
>
>  *** required header files.
>
>  *** 'make menuconfig' requires the ncurses libraries.
>
>  ***
>
>  *** Install ncurses (ncurses-devel) and try again.
>
>  ***
>
> make[1]: *** [scripts/kconfig/dochecklxdialog] Error 1
>
> make: *** [menuconfig] Error 2
>
> "
>
> How can I include the libraries.
Take a close look at the error message, where you find
"Install ncurses (ncurses-devel) and try again.". E.g. on a Debian system a 
call like 
sudo aptitude install ncurses-bin libncurses5-dev
should to the job.

>
>
>
> Thanks and Regards
>
> Ashish Dudeja
Best regards

Niklaus
