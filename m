To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: debugging using bdi2000, unable to proceed. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Apr 2003 18:40:30 +0530."
             <3E9EA7C6.2020605@tataelxsi.co.in>
Date: Thu, 17 Apr 2003 15:45:39 +0200
Message-Id: <20030417134544.300A5C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E9EA7C6.2020605@tataelxsi.co.in> you wrote:
>
> We are using bdi200 for debugging linux kernel (2.4.1 and 2.4.17).
> our target board is mpc8260ADS, with ppcboot 2.0.0
>
> we are using http://www.ultsol.com/PDFS/Tool%20Talk%2002-001a.pdf as a
> refernce to get bdi 2000 setup running.
> Connections are made as per the document.
> bdisetup is run from the host. Using the configuration file.
> We used format IMAGE and file zImage and the image file  loaded to
> 0x400000 using bdi2000.

Don't do this. Build a PPCBoot image as usual using the mkimage tool,
and use PPCboot to download and start the kernel. Use the BDI2000 for
debugging only.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
