Date: Sat, 8 Jan 2000 13:34:54 -0600
From: anthony tong <atong@uiuc.edu>
To: John Buswell <johnb@one.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and aty128fb
Message-ID: <20000108133454.A25347@ux5.cso.uiuc.edu>
References: <20000108110850.A5252@students.uiuc.edu> <Pine.LNX.3.96.1000108181304.23736A-100000@shell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.1000108181304.23736A-100000@shell>; from John Buswell on Sat, Jan 08, 2000 at 01:17:41PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Buswell (Sat, Jan 08, 2000 at 01:17:41PM -0500):
> 
> On Sat, 8 Jan 2000, anthony tong wrote:
> 
> > What if you don't boot with a vmode argument and use the proper video
> > timings provided by fbset after you boot?
> 
> if i don't boot with the vmode option I don't get any display :)

Try this: can you boot into MacOS and run Apple's DeviceNameRegistry?
You should be able to get that from Apple's PCI Device Driver dev kit
(don't have url off hand).

If you can send me a copy of the program's output it'd be appreciated.
The MacOS ATI drivers tend to leave a few clues it its entries there.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
