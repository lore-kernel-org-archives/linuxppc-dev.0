Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 27E58DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 04:36:00 +1100 (EST)
Message-ID: <45E5BD6B.1010509@freescale.com>
Date: Wed, 28 Feb 2007 11:35:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
In-Reply-To: <46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Dan Malek wrote:

> I don't think that would be a problem, and I'd like the
> CPM/QE to share devices because it makes the
> software distributions common to all Freescale
> embedded processors.

I'm willing to use whatever minor number and range the community agrees upon.

An alternative idea, which one person already shot down, was to allow only 4 devices 
normally, but allow more devices if you use udev, since udev doesn't care about minor 
number assignments.  This eliminates the overlap and encourages people to use udev.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
