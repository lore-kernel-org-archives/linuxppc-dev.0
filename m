Date: Mon, 2 Jun 2003 13:53:10 -0700
Subject: Re: bootstrap of virtex-ii pro eval board ML300
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: ??? <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
To: "Kerl, John" <John.Kerl@Avnet.com>
From: Scott Anderson <sanders@mvista.com>
In-Reply-To: <B895EFF5AF34724880036BDB5B5B8148135699@amer22.avnet.com>
Message-Id: <384EB15A-953C-11D7-85A6-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday, June 2, 2003, at 01:48  PM, Kerl, John wrote:
> You're saying that the entire zvmlinux.initrd file
> (2-3 MB, say) is contained in the FPGA bitstream??

I am saying that the entire zImage.embedded (without
an initrd) is in the FPGA bitstream.  Its root partition
is an ext2 partition on the IBM MicroDrive.

   Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
