From: jlhagen@collins.rockwell.com
Subject: Re: RTLinux and mvme26xx cards?
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Date: Fri, 10 Nov 2000 08:26:27 -0600
Message-ID: <OFD3F04212.87F2B25A-ON86256993.004C8A3A@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I seem to be hitting a build problem with the 2.4.-test kernels so I may
not get to try it out. I popped a note to the list yesterday (see 'can't
compile 2.4.0-testx kernels on G4 YDL C.S. 1.2.1') describing my build
errors. I haven't figured out why I can't complete compilation. I was going
to try your 2.4.0 config and patches/vme drivers, then try a fresh
2.4.0-test1 kernel ( based on an email I got) and then play with RTLinux.

Someone sent me an email about using /arch/ppc/boot/zImage which worked on
our boards as well without your patches. From the mail archives I think you
do the memory mapping differently than what is included in the kernel as
well as a different boot loader. Can I get a little more insight on what
your patches are providing.

Thanks,
JH





Gabriel Paubert <paubert@iram.es> on 11/10/2000 02:49:45 AM

To:   jlhagen@collins.rockwell.com
cc:   linuxppc-dev@lists.linuxppc.org

Subject:  Re: RTLinux and mvme26xx cards? :)




On Wed, 8 Nov 2000 jlhagen@collins.rockwell.com wrote:

>
> Hello,
>
> what is the possibility of using FSMLabs RTLinux on mvme26xx boards? IIRC
> RTLinux supports uniprocessor powerpc in the V3 beta series, correct me
if
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
