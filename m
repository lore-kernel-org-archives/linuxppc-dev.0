From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14245.48292.489613.871527@gargle.gargle.HOWL>
Date: Mon, 2 Aug 1999 11:43:32 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: PPP burps in 2.2.10
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.  I'm running a stock kernel.org 2.2.10 kernel on my Powercenter,
connecting through pppd 2.3.7 (R5 dist).  When I download a large file, I get
a pile of messages of two kinds:

FB. overflow: #### (some number)

and

ppp: error in VJ decompression

Is this a config problem, pppd problem, or kernel bug?  How do I go about
trying to locate it?  Has it already been found and fixed in the vger version?

Thanks,

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
