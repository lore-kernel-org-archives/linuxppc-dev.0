From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Graham Stoney" <greyham@research.canon.com.au>,
        "Pavel Roskin" <pavel_roskin@geocities.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Unpacking the mvista kernel RPMs
Date: Sun, 9 Apr 2000 23:25:29 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMKEPJCDAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20000410031456.0B51D3C960@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham,

If you just want to get the files out try this:

work within a temp directory

rpm2cpio < kernel.rpm > kernel.cpio
cpio --make-directories --extract --verbose < kernel.cpio

Enjoy,

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Graham
Stoney
Sent: Sunday, April 09, 2000 11:15 PM
To: Pavel Roskin
Cc: Wohlgemuth Jason; 'linuxppc-embedded@lists.linuxppc.org'
Subject: Unpacking the mvista kernel RPMs



Pavel Roskin writes:
> By the way, I found a newer kernel (March, 23) in
> ftp://ftp.mvista.com/pub/CDK/updates/1.0/ppc_8xx/SRPMS/

How does one go about unpacking one of these RPMs?

I tried ftp'ing the rpm and going:
% rpm -i hhl-kernel-2.2.13-7.src.rpm
% rpm -bp /usr/src/redhat/SPECS/hhl-kernel-2.2.13.spec
...
cp: configs/%{_hhl_kernel_configs}: No such file or directory
Bad exit status from /var/tmp/rpm-tmp.689 (%prep)

Can anyone please help me get the hang of RPM?  I'm sure it's _supposed_ to
make my life easier, but...

Thanks,
Graham


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
