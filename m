Date: Fri, 10 Nov 2000 09:49:45 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: jlhagen@collins.rockwell.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTLinux and mvme26xx cards? :)
In-Reply-To: <OF774F72D8.4D5354AC-ON86256991.007B9E46@collins.rockwell.com>
Message-ID: <Pine.HPX.4.10.10011100948050.19910-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Nov 2000 jlhagen@collins.rockwell.com wrote:

>
> Hello,
>
> what is the possibility of using FSMLabs RTLinux on mvme26xx boards? IIRC
> RTLinux supports uniprocessor powerpc in the V3 beta series, correct me if
> I'm wrong. Using Gabriel's patches I have been able to bring up 2.2.12
> series kernels on our mvme2604 boards. I'm having problems on with the
> 2.4-test series kernels and Gabriel's patches, issue with NFS, but I'm
> starting to wonder about using RTLinux on these boards.

I have never found time to try RTlinux, but I wanted to. I don't
foresee any major problem, except perhaps for interference with my VME
driver (the Universe actually has to act as a cascaded interrupt
controller).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
