Date: Wed, 17 Mar 1999 14:13:24 -0600 (CST)
From: /* Vinai */ <vroopcha@post.its.mcw.edu>
To: Tim Carroll <tim@radcom.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: clock/bogomips in cpuinfo
In-Reply-To: <Pine.LNX.3.96.990317111511.1153C-100000@radcom.org>
Message-ID: <Pine.SOL.3.96.990317141011.14032D-100000@post.its.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Mar 1999, Tim Carroll wrote:

}It works great and on the first try with Paul M's stock 2.2.1 kernel, but
}a peek at /proc/cpuinfo tells me clock : 195MHZ and bogomips : 403.87. 

I get almost the same result with my 604e/233 MHz card in my 7500, i.e.
the /proc/cpuinfo says 195 MHz, but the BogoMips says 466 (IIRC).  In
MacOS, the CPU and bus speeds are what they are supposed to be.

This has not affected anything I am doing, so I did not bother too much
with it.  But I guess this is not something peculiar to my machine or
card, as I first thought ...

vinai





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
