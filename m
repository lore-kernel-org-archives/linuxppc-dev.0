Message-ID: <3C7D0AB9.5070801@pacbell.net>
Date: Wed, 27 Feb 2002 16:35:05 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: John Tyner <jtyner@cs.ucr.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Tyner wrote:
>>From andrew may <acmay@acmay.homeip.net>:
>
> Added Am79C874 support
> Improved find_phy function:
>   use Min/Max Phy addr defines (not sure if MAX_NUM_PHYS is still needed)
>   continue to look for phy if we find a phy we don't support instead of panic
>   detect/report missing pullup problem
>   removed unused phy_id_done
> enet_open
>   checks for undetected phy and fails if no know phy is present
> enet_open/close
>  checks for completion of soft reset (writing 0 to soft reset has no effect)
>
>
> ------------------------------------------------------------------------


Thanks,

I want to try in on a few boards I have before it goes in.

--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
