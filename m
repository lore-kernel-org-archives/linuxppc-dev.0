Message-Id: <9907179321.AA932188006@smtplink.dscc.dk>
Date: Sat, 17 Jul 1999 06:05:57 +0200
From: "RTHEANDE"<rtheande@dscc.dk>
To: <linuxppc-dev@lists.linuxppc.org>, <linux-embedded@waste.org>
Subject: MPC860T boot problem (hardware level)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


     Hi,
     
     Warning, this is a hardware problem so software-only geeks can move on 
     ;-) The HW is going to run Linux so it's not entirely off-topic.
     
     I have a homemade board build around an MPC860T. It fails to boot in 
     an interesting way (well, maybe not).
     
     Boot prom is 8 bit wide. Reset looks good. Instruction fetch starts at 
     0x100. 4 bytes are fetched back to back (data even looks OK).
     Then nothing more happens... No more fetching - no activity at all. 
     Sysclk is still running (20MHz).
     Until approx. 6.7 secs later when watchdog kicks the reset to start it 
     all over.
     
     What is going on? Why is only one instruction fetched? Suppose the 
     instruction is illegal, would the above happen or should the exception 
     handler kick in?
     
     Any hints, advices, vague ideas, etc. are very much appreciated - this 
     is beginning to get to me...
     
     Thanks,
     
     Robin Theander


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
