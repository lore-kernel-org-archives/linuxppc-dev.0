From: Ryan Nielsen <ran@krazynet.com>
Date: Wed, 25 Aug 1999 16:32:10 -0700
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Various PMac PCI patches
Message-ID: <19990825163210.A6902@gondolin.asf>
References: <19990819204726.A82@gondolin.asf> <199908251727.TAA00387@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908251727.TAA00387@piglet.cpu.lu>; from Michel Lanners on Wed, Aug 25, 1999 at 07:27:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
> Can you check this patch still works for you? It should now also
> correct the IO-space addresses, so your PCI card should work in both
> buses.

It works OK.
I think you can get rid of the check for VGA when enabling memory/IO.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
