From: Ryan Nielsen <ran@krazynet.com>
Date: Thu, 19 Aug 1999 20:47:26 -0700
To: Michel Lanners <mlan@cpu.lu>
Cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
Subject: Re: Various PMac PCI patches
Message-ID: <19990819204726.A82@gondolin.asf>
References: <199908082034.WAA02973@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908082034.WAA02973@piglet.cpu.lu>; from Michel Lanners on Sun, Aug 08, 1999 at 10:34:15 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
> 2. I've hacked pmac_pcibios_fixup with a few changes:
> 
> - It now checks for PCI buses other than the first one, on all bridges.
> This should help on the 7x00/8x00 machines (bandit and chaos host
> bridges) as well as on the 9x00 (two bandit bridges; second bus would
> be invisible up to now). If anyone has a 9x00, can  you test if this
> works? For me it only detects one of two devices on bus 1....
 
It detects two out of two on mi 9600.

isa_io_base is set to the address of bus 0 !
so inl() and friends use wrong address for cards on bus 1.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
