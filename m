Date: Sat, 8 Jan 2000 13:43:14 -0600
From: anthony tong <atong@uiuc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and aty128fb
Message-ID: <20000108134314.B25347@ux5.cso.uiuc.edu>
References: <Pine.LNX.3.96.1000108181304.23736A-100000@shell> <20000108194648.013972@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000108194648.013972@192.168.1.10>; from BenH on Sat, Jan 08, 2000 at 07:46:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH (Sat, Jan 08, 2000 at 07:46:48PM +0100):
> On Sat, Jan 8, 2000, John Buswell <johnb@one.net> wrote:
> >if i don't boot with the vmode option I don't get any display :)
> >
> >is there any place that documents what parameters I can pass to the kernel
> >with video= ? 
> 
> We should add a hack to atyfb that uses mode 17 by default on all iMacs.
> Could everyone with an iMac out there tell me the value of
> 
> /proc/device-tree/compatible

One more thing that I'd like to do with the iMacs that I haven't gotten
around to--getting i2c support going so that we can adjust the screens
brightness, contrast, centering, etc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
