Date: Thu, 11 Apr 2002 15:36:42 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411153642.C18158@ecam.san.rr.com>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CB5A370.4080409@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 02:53:36PM +0000, Armin wrote:
>
> John Tyner wrote:
> > I remember seeing something awhile ago about early boots, but I didn't
> > think it was for Walnut. Where is it/would it be?
> >
> > On Thu, 11 Apr 2002, Armin wrote:
> >
> >
> >>John Tyner wrote:
> >>
>
>
> David G did something and he hit the head_4xx.S & ppc4xx_setup.c and a
> few header files imb405gp.h

This patch is to remove the need for the BASE BAUD define. If we ever start
trying to get a single kernel to build for multiple 405 boards that run at
various clock rates it becomes helpful to calc the base baud for the serial
ports rather than forcing it at compile time.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
