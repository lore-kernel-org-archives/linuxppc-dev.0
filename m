Message-Id: <l03130306b3026e83e6a8@[35.9.15.82]>
In-Reply-To: <9903021553.AA29088@mayan.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 2 Mar 1999 23:45:36 -0500
To: mayan <mayan@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
From: mukesh agrawal <agrawal@ais.org>
Subject: Re: Turning off paging to disk?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:53 AM -0500 3/2/99, mayan wrote:
>How does one turn off paging to disk?
>
>I am booting with root=/dev/ram, with no disk, and I was
>wondering how to disable swapping (or at least fool Linux
>into swapping from memory to memory :)

iirc, swapping is activated by the program swapon. look through your
startup sequence to figure out when this is activated, and disable it. or,
if you just need to disable swapping temporarily, i believe there's a
swapoff program. finally, if you comment out the lines in /etc/fstab that
indicate what your swap partition(s) are, then swapon probably won't do
anything.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
