Date: Fri, 26 Feb 1999 10:13:38 -0600 (CST)
From: puetzk6715@uni.edu
Subject: Bug in G3 serial - stty causes total lockup
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990226100814.539037820C-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just moved my printer from a Localtalk network to my Linux box. I then
BootX'ed into Linux (1.0.2b4 and Pauls 2.2.1) to try the HP 660C
instructions from the FAQ-o-Matic. However, attempting to use stty raw
57600 -echo crtscts < /dev/ttyS1 completely locked up the machine. I
rebooted (OF-boot), and all worked fine. Went back to MacOS, BootX'ed (I
wanted to see if this was the problem), and... it locked up again. 

I finally turned off LocalTalk on the MacOS (which I was going to do
anyway now that the printer is directly connected) and now stty works
reliably after BootX. However, I don't like Linux to crash, even in
uunrealistic situations (like changing the speed on a port MacOS thought
was LocalTalk). Anyone want to look at this? I'm afreaid of the
kernel-code...


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
