Message-Id: <5.1.0.14.2.20011109125808.0300b040@falcon.si.com>
Date: Fri, 09 Nov 2001 13:08:14 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Linuxppc and MPC8255 routing performance
In-Reply-To: <3BEC0578.9020704@embeddededge.com>
References: <9729.011107@vanet.com.br>
 <01110818021400.00999@scop.digitel.com.br>
 <3BEAFCEB.3090604@embeddededge.com>
 <01110912552900.03277@scop.digitel.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:34 AM 11/9/01 -0500, Dan Malek wrote:

>Ricardo Scop wrote:
>
>
>>By "backside" memory you mean ... the internal data cache, perhaps?
>
>No, bad use of words on my part.  The 8260 has a local bus that can only
>be accessed from the CPU core and CPM (it's not on the 60x bus).  Maybe
>the 8255 doesn't have this feature, I don't remember.
>
>
>         -- Dan

The 8255 uses the 8260 "local bus" connections for the PCI bus.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
