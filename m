Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D2A0B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 12:15:53 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAA17QQL019876
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 20:07:26 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAA1Fo3E116610
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 20:15:50 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAA1Fnlu003632
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Nov 2009 20:15:49 -0500
Date: Mon, 9 Nov 2009 20:15:47 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Invalidate Data Cache from User Space
Message-ID: <20091110011547.GD30489@zod.rchland.ibm.com>
References: <BB99A6BA28709744BF22A68E6D7EB51F03310AFEC3@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310AFEC3@midas.usurf.usu.edu>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 09, 2009 at 11:10:42AM -0700, Jonathan Haws wrote:
>All,
>What is happening is the dcbi instruction will fail.  I get an Illegal Instruction message on the console and my program exits.
>
>Is there a reason I cannot call dbci from a user space application, or is there something wrong in my code?  Even better, is there a working and tested function that I can call from user space to invalidate a portion of the data cache?

dcbi is a priviledged instruction on 4xx.  You can only execute it from
supervisor mode (kernel).

josh
