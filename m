Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3A87B6F0C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 18:18:25 +1000 (EST)
In-Reply-To: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <OF0E653CF5.2ED4C3A3-ONC1257751.002C6D6E-C1257751.002C903E@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 Jun 2010 10:06:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Shawn Jin <shawnxjin@gmail.com>
>
> I'm porting a mpc870 board to the powerpc arch. The base is the
> adder-875 board. My first try to boot the cuImage.my870 is
> experiencing a machine check. And I have no clue where to look. Any
> help?
>
> => bootm 1000000
> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.33.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    747319 Bytes = 729.8 kB
>    Load Address: 00400000
>    Entry Point:  004004d4

Load and Entry Point should probably be 0

 Jocke
