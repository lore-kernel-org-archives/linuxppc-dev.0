Date: Tue, 4 May 1999 19:06:30 -0500 (CDT)
From: Derek Moeller <moeller@networksplus.net>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC
In-Reply-To: <199905042220.PAA17423@soda.CSUA.Berkeley.EDU>
Message-ID: <Pine.LNX.3.96.990504183508.3189A-100000@ns1.networksplus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 May 1999, Sriranga Veeraraghavan wrote:

> 
> 
> Hi,
> 
> I have been trying to compile USB support into the 2.2.5 kernel on
> LinuxPPC using the uusb driver.
> 
> On my LinuxPPC machine I keep getting errors that the struct s_snode
> has no element named lock. I checked in usb-slist.h and this struct's
> definition does not have an element named lock, nevertheless it is
> referenced throughout the usb driver code. 
> 
> If anyone has been able to comple the uusb driver on LinuxPPC, I would
> appreciate some pointers.  Also if there is a version of the usb
> drivers that compiles with kernel 2.2.0pre6, I would like to use it,
> since the SMP support on 2.2.1+ has been quite buggy for me.
> 
> Thanks,
> 
> 
> ----ranga <ranga@soda.berkeley.edu>
> 
	I've used the 2.2.1 kernel from linuxppc.org
(/linuxppc/kernel/powermac/linux-pmac-2.2.1.tar.gz) that comes with USB
support patched into the kernel and in good working order. You could
probably patch the source up to 2.2.5 just fine.

+----------------------------------------+
| Derek Moeller moeller@networksplus.net |
|     Linux for PowerPC User, Student    |
|   http://www.networksplus.net/moeller	 |
|	*	   *		*	 |
|    "aut inveniam viam aut faciam"	 |
+----------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
