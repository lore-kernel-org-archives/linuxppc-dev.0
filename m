Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6AD7667A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 21:27:45 +1100 (EST)
Date: Wed, 16 Feb 2005 02:27:42 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050216102742.GC989@gate.ebshome.net>
References: <c3d0340b05021518037b1758cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05021518037b1758cc@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Incomplete network configuration information when booting from
	NFS root on Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 15, 2005 at 06:03:12PM -0800, Shawn Jin wrote:


> zmii0: input 0 in SMII mode

...

> zmii0: input 1 in RMII mode

BTW, this is wrong. All inputs must be in the same mode. This is not a 
cause for you current problem, but will be the next one :).

--
Eugene
