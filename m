Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 42006680E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 09:17:13 +1000 (EST)
Date: Thu, 11 Aug 2005 16:17:10 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>, ppcembed <linuxppc-embedded@ozlabs.org>
Message-ID: <20050811231710.GB5796@gate.ebshome.net>
References: <c3d0340b050811154148164691@mail.gmail.com>
	<20050811231454.GA5796@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050811231454.GA5796@gate.ebshome.net>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 04:14:54PM -0700, Eugene Surovegin wrote:
> > MMU:exit                                                                        
> > setup_arch: enter                                                               
> > setup_arch: bootmem                                                             
> > arch: exit                                                                      
> > ??????                                              
> 
> Try disabling early text debugging (all that "MMU:..." stuff).
> 

Also, make sure you pass correct "console=..." line to the kernel 
(with correct device name and baud rate).

-- 
Eugene
