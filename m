From: bskrypny@MBnet.MB.CA
Message-Id: <v01540b05b38935a82d97@[192.168.100.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 13 Jun 1999 03:22:44 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: PMU and PowerBook
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am trying to play with PMU on my PowerBook G3 Series. Specifically I am
trying to see the battery state by using PMU_BATTERY_STATE command.
According to the source code PMU should return 8 bytes in response to this
command.

Can anyone point me where I can find out the meaning of those 8 bytes. (I
get the first 4 bytes as 0s and in the rest some frequently changing data).


PS: Benjamin, thanks for your response on my cuda question.

Bill.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
