Subject: Unpacking the mvista kernel RPMs
To: pavel_roskin@geocities.com (Pavel Roskin)
Date: Mon, 10 Apr 2000 13:14:55 +1000 (EST)
Cc: jason_wohlgemuth@gilbarco.com (Wohlgemuth Jason),
        linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> from "Pavel Roskin" at Apr 07, 2000 11:20:52 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000410031456.0B51D3C960@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
