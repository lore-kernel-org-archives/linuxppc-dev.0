Message-ID: <3D3FBFBE.9050607@attbi.com>
Date: Thu, 25 Jul 2002 02:07:10 -0700
From: Dan Taylor <danieltaylor@attbi.com>
Reply-To: danieltaylor@acm.org
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Fwd: Re: How to get rid of unused data in LKM]
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-------- Original Message --------
Subject: Re: How to get rid of unused data in LKM
Date: Thu, 25 Jul 2002 02:04:53 -0700
From: Dan Taylor <danieltaylor@attbi.com>
Reply-To: danieltaylor@acm.org
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
References: <20020724154914.5C03C10875@denx.denx.de> <3D3FA821.40106@esd-electronics.com>

Couldn't you do a kernel file open during module_init, store the
PCI device code and close the file?

Regards,

Dan

Matthias Fuchs wrote:

 >
 > Hi Wolfgang,
 >
 >>
 >>
 >> Why don't you load the firmware using some  ioctl()  _after_  loading
 >> the module?
 >
 > Of course this is a good and definetly the default solution. But our
 > application requires
 > that everything is done by the init function of the module.
 > Life would be boring and mailing list obsolete, if we can always use the
 > default solutions :-)
 >
 >>> But after doing so, the firmware data is still wasting kernel memory
 >>> on the host system
 >>> and is not used anymore.
 >>> How can I free that memory ? Is there a better way to handle that data ?
 >>
 >> If you really think you must link the data with the  module:  Declare
 >> it using "__initdata" ?
 >
 > I think that John is right. __initdata only makes sense, when the module
 > is compiled into
 > the kernel. But I will check it again, just to be sure.
 >
 > Matthias
 >
 >
 >
 >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
