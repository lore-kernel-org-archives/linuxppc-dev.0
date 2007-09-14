Return-Path: <erik@dd.nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id 4FAC2DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 10:46:12 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 10:46:11 +1000 (EST)
Received: from bohr.dd.nec.com.au (bohr.dd.nec.com.au [172.31.20.11])
	by deer.dd.nec.com.au (8.12.5/8.12.5/Debian-1) with ESMTP id
	l8E0kAwX021553
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Sep 2007 10:46:11 +1000
Received: from dvalin ([172.31.20.70])
	by bohr.dd.nec.com.au (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	l8E0kAkU016191
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Sep 2007 10:46:10 +1000
Date: Fri, 14 Sep 2007 10:46:21 +1000
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash on ep8248e standard motherboards
Message-ID: <20070914004621.GA9022@dd.nec.com.au>
References: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
	<20070913082558.GB8968@dd.nec.com.au>
	<46E944BE.1010007@qstreams.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46E944BE.1010007@qstreams.com>
From: erik@dd.nec.com.au (Erik Christiansen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 10:10:06AM -0400, Ben Warren wrote:
> >  
> MIRRORX16 is the correct type for Spansion GL series NOR flash. AMD spun 
> off their flash business a while ago and renamed it Spansion. If you 
> look on the datasheet you'll see that Spansion calls the GL technology 
> 'MirrorBit', and in all likelihood the device has a 16-bit data bus. The 
> AMD algorithm may work but the MIRRORX16 definitely will.

Yes, the "Flash Organisation" section of the ep8248e manual shows two
16-bit devices. (That's what seemed erroneous in the BDI2000 config file
supplied with the card. ;-)

Many thanks for putting me on the right track w.r.t. CHIPTYPE. It'll
save me trying all the wrong guesses first.

Regards,
Erik
