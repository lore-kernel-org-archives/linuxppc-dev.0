Reply-To: <govindan@tejasnetworks.com>
From: "Govindan" <govindan@tejasnetworks.com>
To: "'Matthew Locke'" <mlocke@mvista.com>,
        "'Paolo Scaffardi'" <arsenio@tin.it>
Cc: "'linuxppc-emb'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PCMCIA - another step...
Date: Thu, 14 Dec 2000 12:06:18 +0530
Message-ID: <00e601c06598$2b171020$1b01a8c0@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <39E73DE0.F95F057F@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Paolo Scaffardi,

I am unable to get these patches. I have the HardHat 1.2 CD-ROM
and would like to use this patch for a CLLF board with an IBM micro drive.
Could you provide the mechanism to access this location?
Thank you in advance,

Govindan.

"Code it clear rather than clever"
---------------------------------------------------------------------
Govindan  K Thrithala                 Tel: +91-80-226-7495x4033
Tejas Networks India Pvt. Ltd.     Fax: +91-80-226 7494
49, Khanija Bhavan, Race Course Road
Bangalore 560 001
-------------------------------------------------------------------
"I care for future, because I spend rest of my life there"





-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Matthew
Locke
Sent: Friday, October 13, 2000 10:23 PM
To: Paolo Scaffardi
Cc: linuxppc-emb
Subject: Re: PCMCIA - another step...



Paolo Scaffardi wrote:

I have some patches for the kernel and pcmcia-cs for the 8xx on our ftp
site.

ftp://ftp.mvista.com/pub/area51/ppc_8xx

I moved Magnus stuff up to pcmcia-cs-3.1.19 and there is a patch for the
ioremapping of _IO_BASE.  I chose 0x80000000 but that probably is not
the best place to put it.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
