Message-Id: <200108292010.QAA06333@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to boot linux on a MVME5100
Date: Wed, 29 Aug 2001 16:02:35 -0400
References: <85256AB7.00607D65.00@pine.cspi.com>
In-Reply-To: <85256AB7.00607D65.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am also using an MVME5100 it works so far except with the new 2.4.9 devel
tree I can  no longer build a zImage.initrd. make zImage.initrd completes and
is happy, but I never find the file in the tree anywahere. I have cheked pp3,
prep, common, simple and images. The most I can find is a vmlinux.gz Any
ideas on this?

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
