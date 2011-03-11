Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1E48B6FC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 07:26:03 +1100 (EST)
Message-ID: <56564.94.211.195.167.1299875156.squirrel@gate.crashing.org>
In-Reply-To: <AANLkTinfxdckX=sYk5fX4vRhnmJNTHnytWkUW0w_HMj4@mail.gmail.com>
References: <AANLkTinfxdckX=sYk5fX4vRhnmJNTHnytWkUW0w_HMj4@mail.gmail.com>
Date: Fri, 11 Mar 2011 21:25:56 +0100 (CET)
Subject: Re: ongoing mesh saga ...
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "kevin diggs" <diggskevin38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Is there any chance someone with a compiler newer than 4.3.5 would be
> willing to get me -S output from a mesh compile (preferably not a
> module unless it does not make any difference) for 2.6.36. Using:
>
> head -1 <top>/drivers/scsi/.mesh.o.cmd
>
> you can get a command line which can then be edited to get a script to
> do a -S compile (watch out for the '\#' in KBUILD_STR(s)).

make drivers/scsi/mesh.s

File sent separately, I doubt the list wants to see it.


Segher
