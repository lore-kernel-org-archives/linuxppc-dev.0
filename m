Message-ID: <3DBEF0B4.3050508@pop.agri.ch>
Date: Tue, 29 Oct 2002 21:33:56 +0100
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: vinai <vroopcha@mcw.edu>
Cc: Debian PowerPC List <debian-powerpc@lists.debian.org>,
	"LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sonnet G4 800 in 1st gen PCI mac + linux ...
References: <Pine.LNX.4.44.0210291117140.311-100000@kaiso.biophysics.mcw.edu>
In-Reply-To: <Pine.LNX.4.44.0210291117140.311-100000@kaiso.biophysics.mcw.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


vinai wrote:

> Hey Folks,
>
> I posted a note to one of the mac sites with this question and I thought
> I'd ask here as well.  Is anyone using (or has tried to use) one of the
> new Sonnet G4 CPU's in a 1st generation PCI mac (7300 to 9600) with any
> degree of success ?  I'm considering trying this in my 8500 ...

Well, I can't speak for sonnet nor for G4, but I recentley got a G3/533
ZIF for my 8600/200. It was a nightmare until I found out that this CPU
doesn't like interleaving. After de-interleaving the DIMM's I could run
the CPU with 50MHz Bus and 500 MHz CPU Speed. L2 is half of the CPU.

My two rp.

Andreas

2.4.20-pre11-ben0
[andreas@pm8600 cvs]$ cat /proc/cpuinfo
cpu             : 740/750
temperature     : 33 C (uncalibrated)
clock           : 510MHz
revision        : 3.2 COP (pvr 0008 8302)
bogomips        : 999.42
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
detected as     : 16 (PowerMac 8500/8600)
pmac flags      : 00000000
memory          : 560MB
l2cr override   : 0xb9080050
pmac-generation : OldWorld


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
