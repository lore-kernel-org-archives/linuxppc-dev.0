Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 52D1ADDE22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 04:27:13 +1100 (EST)
In-Reply-To: <45E5B604.904@freescale.com>
References: <45E46976.6060600@freescale.com>
	<29c13109971547687159078eacdea008@kernel.crashing.org>
	<45E592DC.9060700@freescale.com>
	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>
	<45E5B604.904@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Wed, 28 Feb 2007 12:27:06 -0500
To: Timur Tabi <timur@freescale.com>
Cc: Torben.Mathiasen@hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2007, at 12:04 PM, Timur Tabi wrote:

> ...  However, ttyCPM0 is currently assigned to 46, and device 50 is  
> an Altix serial card.  The only way to give the CPM 6 or 8 slots  
> without moving it is to overlap the Altix card.

Then, this is currently broken in all cases
and needs to be fixed since the CPM/CPM2
could have up to six UART ports.

> Now I don't know anything about the Altix card, so I don't know if  
> it's possible to use that card on a system with a CPM or a QE.  If  
> it isn't, then I don't know if overlapping minor numbers is still a  
> problem.

I don't think that would be a problem, and I'd like the
CPM/QE to share devices because it makes the
software distributions common to all Freescale
embedded processors.

> If we move CPM/QE to 192, then I can change the CPM device driver  
> to reflect that, but I don't know what that means for older kernels.

That would be bad.  It has nothing to do with the
kernel, but we have finally survived the distribution
updates to ttyCPM, and I don't want to go through
that again just because of QE.

Thanks.

	-- Dan
