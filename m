From: clark@esteem.com
Message-Id: <5.0.0.25.1.20001228172655.00a6f940@pop.esteem.com>
Date: Thu, 28 Dec 2000 17:33:48 -0800
To: "Navin Boppuri" <nboppuri@trinetcommunication.com>
Subject: Re: Neighbour Table Overflow on NFS Server
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <002f01c070de$15248760$4a1f76d8@washington>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

         Have you recompiled your kernel lately? You might have changed the
SCC number for your Ethernet interface by accident. I did this once and
went nuts trying to figure out what was wrong. Try changing it and see if
it works. If not change it back and continue to go nuts. ;-)

         Good Luck


At 02:54 PM 12/28/00 +0000, you wrote:

>Hello,
>
>I have been debugging my custom 823 board. I have an NFS Server setup on
>which my kernel on the board mounts. I have using this server without any
>problems for more than a month. All of the sudden, my NFS Server complains
>of "Neighbour Table overflow" . The NFS Server was not modified, nor
>restarted. The error also says that the Server returned error -5.  Can
>someone suggest any remedy for this problem?
>
>Sincerely,
>Navin Boppuri
>
>

*****************************************************************
   If you live at home long enough, your parrents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 all rights reserved. May not be sold or
used for advertisements.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
