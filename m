From: jpgarcia@execpc.com
Message-Id: <200011072304.RAA23594@localhost.localdomain>
Date: Tue, 7 Nov 2000 17:04:09 -0600 (CST)
Subject: Re: bad vidmode on debian install
To: sjh@wibble.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001108094625.B10734@svana.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  8 Nov, Steven Hanley wrote:
> it is a Mach 64 video card
>
>> Do you have 834x624 and more than 8 bit color depth? If yes, change the
>> resolution or set the color depth to 8 bit.
>
> wouldnt doing this involve the passing of a video=atyfb:vmode:8 or some such
> ?

vmode for resolution, using values available in nvvideo's manpage
cmode for color mode (bit count works).

in reference to the nervous text, I get this on my PDQ when the mclk is
set incorrectly.  this can be specified using the mclk: param.  my
cmdline is "video=atyfb:vmode:14,cmode:32,mclk:100", but I am aware that
earlier systems, even wallstreets use smaller mclk values.  the
default/autodetect in the kernel does not work for me.  could try 83 or
60, two other fairly successful values IIRC.

Hope this is helpful.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
