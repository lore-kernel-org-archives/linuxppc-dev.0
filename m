Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBBF1DDE33
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 03:59:44 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: macros and dtc
Date: Sun, 18 Feb 2007 10:58:44 -0600
To: David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>,
	Segher Boessenkool <segher@kernel.crashing.org>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After spending some time this weekend cleaning up dts files I figured  
it would be nice if we can some to consensus on how we are going to  
do macro support.  There is clearly a lot of duplication between  
dts's and it only gets worse when you add in slight variations for  
revs of boards.

I wasn't sure if we are thinking of using some style of preprocessor  
(cpp, m4, etc..) or trying to add something into dtc itself.

However, I think it would be good for us to get some traction towards  
a solution for in kernel dts files.

- k
