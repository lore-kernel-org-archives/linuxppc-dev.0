Message-ID: <B895EFF5AF34724880036BDB5B5B814813569B@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Scott Anderson'" <sanders@mvista.com>,
	"Kerl, John" <John.Kerl@Avnet.com>
Cc: ??? <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: bootstrap of virtex-ii pro eval board ML300
Date: Mon, 2 Jun 2003 13:52:15 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


News to me.

Thanks.

-----Original Message-----
From: Scott Anderson [mailto:sanders@mvista.com]
Sent: Monday, June 02, 2003 1:53 PM
To: Kerl, John
Cc: ???; linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootstrap of virtex-ii pro eval board ML300


On Monday, June 2, 2003, at 01:48  PM, Kerl, John wrote:
> You're saying that the entire zvmlinux.initrd file
> (2-3 MB, say) is contained in the FPGA bitstream??

I am saying that the entire zImage.embedded (without
an initrd) is in the FPGA bitstream.  Its root partition
is an ext2 partition on the IBM MicroDrive.

   Scott

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
