Message-ID: <67505026E29DD311A9AA00508B7315F350A61D@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: uart.c 
Date: Tue, 19 Dec 2000 17:10:01 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
I want to send video/raw data over scc2 using uart.c on ttyS1.
I am using 860T and 2.2.14 kernel

The receive side hangs, stops receiving data, it won't start up if it gets
into a weird state, which I don't know what that is. I am thinking it is in
my data somewhere or my port settings that turns off the receive all
together? Could this be? Can I start it back up somehow? I used stty with
raw to allow for all characters, but it does not seem to make a difference.
Transmit works like a charm.

My goal is to then bind ttyS1 to ppp.

Any clues are greatly appreciated,
thank you in advance...

--Julia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
