Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Is GCC >= 3.1 available for ELDK ? (or other means to compile Ada code)
Date: 06 Jun 2003 13:34:00 +0200
Message-ID: <87el27wic7.fsf@deepthought.outer.space.org>
References: <30C145E544071F4FB8B627789F7910BD328FEE@csy-exchange1.giat.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Albert,

> Here at work I've been asked to get some Ada code ported on an
> embedded, MPC855T-based platform using ELDK 2.02.
>
> By the look of it, there are no major risks with repsect to the
> scheduler or libraries or performance; the only problem is getting
> to compile Ada code.
>
> GCC supports Ada from version 3.1.1 up, but ELDK 2.0.2 features 2.95.4.
>
> Is there a version of GCC >= 3.1.1 prepackaged for ELDK?

Short answer - no.

The ELDK still contains the reliable 2.95.4 compiler + associated
binutils because there were several problems with the >=3.0 toolchains
on the ppc platform.  To check the situation, I recently compiled gcc
3.2.2 + binutils 2.13 as a cross-compiler for the 8xx platform without
major problems out of the box.  A linux kernel compiled with the setup
ran with no noticeable difficulties so I am pretty confident that
the setup is stable for that platform.

The only reason that there is no pre-packaged gcc >= 3.1 for the ELDK
is the well known 24h/day limit and the fact that no customer demanded
a newer gcc as yet.

Hope that helps
  Detlev

--
Spelling is a lossed art


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
