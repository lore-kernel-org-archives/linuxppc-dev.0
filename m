From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Stefan Jeglinski" <jeglin@4pi.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
Date: Wed, 16 Oct 2002 14:16:13 +0200
Message-Id: <20021016121613.26836@192.168.4.1>
In-Reply-To: <p05100302b9d2ade72041@[192.168.0.8]>
References: <p05100302b9d2ade72041@[192.168.0.8]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Have moved the 7000 to the top slot on the 9500, 2 monitors attached.
>
>When using 2.4.20-pre9-ben0, booting into RL3 (not troubleshooting X
>at this point) and kernel arg video=radeon:1024x768-16@75, the
>console boot briefly appears to start in accelerated mode, then the
>monitor goes black and stays that way. However, I can tell from
>listening to the disks that the boot proceeds normally.

What kind of monitors ? 2 CRTs ? 1 LCD and 1 CRT ?

The problem is apparently due to radeon_get_moninfo not finding
anything, can you eventually force rinfo->crtDisp_type to MT_CRT
and see if that helps ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
