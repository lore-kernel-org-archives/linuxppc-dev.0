Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id 8E07ADDF3F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 08:48:58 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so2058409wra.1
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 15:48:56 -0700 (PDT)
Subject: Re: Kconfig debug help
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <20080805213759.96642158806D@mail101-wa4.bigfish.com>
References: <20080805213759.96642158806D@mail101-wa4.bigfish.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 05 Aug 2008 18:48:48 -0400
Message-Id: <1217976528.2328.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-05 at 15:37 -0600, John Linn wrote:
> I’m trying to debug some Kconfig problems and am looking for a way to
> get more debug output.
> 
>  
> 
> I have used KBUILD_VERBOSE=1 on the command line and it didn’t help
> much.
> 
>  
> 
> I’m seeing an issue with creating a new defconfig file for a board.  I
> get the .config created, then copy it to a defconfig, and then it
> doesn’t do anything when I run make with the defconfig file.  

Yeah, I hit that myself this weekend.  It's a bug in the Kconfig area.
It's 1/2 fixed in the latest Linus and powerpc trees.

josh
