Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8B0D7B710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 05:11:27 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so722705rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jul 2009 12:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>
	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Thu, 2 Jul 2009 14:11:06 -0500
Message-ID: <97dd5fd20907021211rca94918ta40f03a1b2036744@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Here is what's happening:
> *************************************************************************
> RAMDISK: gzip image found at block 0
> VFS: Mounted root (ext2 filesystem) on device 1:0.
> Freeing unused kernel memory: 112k init
>
> <4 minutes pass>
>
> init started: BusyBox v1.7.1 (2008-04-02 09:14:47 MEST)
>
> <2 minutes pass>
>
> starting pid 403, tty '': '/etc/rc.sh'
>
> < etc... >
> *************************************************************************

went out to lunch for 20 minutes, new output on screen:
*************************************************************************
Freeing unused kernel memory: 112k init
init started: BusyBox v1.7.1 (2008-04-02 09:14:47 MEST)
starting pid 403, tty '': '/etc/rc.sh'
starting pid 408, tty '': '/bin/application'
starting pid 409, tty '': '/bin/sh'
### Application running ...
process '/bin/application' (pid 408) exited. Scheduling it for restart.
starting pid 411, tty '': '/bin/application
*************************************************************************
