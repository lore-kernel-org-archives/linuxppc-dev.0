Date: Wed, 17 Mar 1999 11:48:03 +0000 (/etc/localtime)
From: Tim Carroll <tim@radcom.org>
Reply-To: Tim Carroll <tim@radcom.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: clock/bogomips in cpuinfo
In-Reply-To: <199903170559.XAA28720@lists.linuxppc.org>
Message-ID: <Pine.LNX.3.96.990317111511.1153C-100000@radcom.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Greetings,

I just received a long-awaited CPU upgrade for my 9500. 

It's the MacTell PowerJolt 400mHz/200mHz bus with 1024K cache.

It works great and on the first try with Paul M's stock 2.2.1 kernel, but
a peek at /proc/cpuinfo tells me clock : 195MHZ and bogomips : 403.87. 

I'm a curious of what these terms might mean in this context and if it
would be possible to effectively adjust these as settings somewhere. 

Otherwise I would appreciate any pointers to discussions of the dynamics
of G3 upgrade configuration or terminology, if these exist.

Thank you,

Tim Carroll









[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
