Message-Id: <9904152034.AA48802@marc.watson.ibm.com>
To: Dean Luick <dean@natinst.com>
Cc: costabel@wanadoo.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Patch]linuxppc gnuplot segfaults in save 
In-Reply-To: Message from Dean Luick <dean@natinst.com>
   of "Thu, 15 Apr 1999 14:00:36 CDT." <37163753.D2022EDD@natinst.com>
Date: Thu, 15 Apr 1999 16:34:48 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	You can try invoking EGCS with the additional commandline argument
-mdebug-arg for it to print out additional information about how it is
advancing through the arguments of functions and figure out where in
rs6000.c:function_arg() it is not matching what fprintf expects.  FP gets
very complicated.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
