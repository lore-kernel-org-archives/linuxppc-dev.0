Message-ID: <C08678384BE7D311B4D70004ACA3710511194720@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ELDK on windows/cygwin 
Date: Thu, 27 Feb 2003 14:14:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cygwin is slow -- in my experience, about 10x - 20x
slower than native Linux on the same hardware.

If you get a CD of your favorite distro and install
it on a spare PC, you'll be up and running in (from
my experience) less than an hour.  Meanwhile, if you'd
started a kernel build (from clean) in Cygwin at the
same time, it would barely be started.

Cygwin is very nice for *small* situations where a
software vendor has some code that runs on Unix,
and wants a quick-and-dirty way to "port" that
software to Windows.  (This is exactly what Xilinx
does with what they call "Xygwin".)

But Cygwin is not a practical way to get any serious
work done.


-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, February 27, 2003 12:33 PM
To: Prakash kanthi
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK on windows/cygwin



In message <20030227173016.61851.qmail@web41209.mail.yahoo.com> you wrote:
>
> Does anyone know if ELDK is available for Windows

No, it is not.

> platform (like with cygwin, etc...)? Did anyone try
> using ELDK on windows/cygwin?

We had a few customers asking for it, but it would be a major PITA to
port, and we have zero windoze experience (DENX  is  100%  Microsoft-
free  :-)  and  it  is so much easier to use a Linux server (probably
running Samba to act as windoze file server).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Certainly there are things in life that money  can't  buy,  but  it's
very funny - Did you ever try buying them without money? - Ogden Nash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
