Date: Sat, 03 Jun 2000 16:34:13 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: How to define global as parameter in module source (to use in insmod)
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <39396BC5.CDE181D9@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Global variable in module source can be set with the command line insmod
like:
    insmod skull skull_ival=666
but with kernel 2.1 the variable skull_ival in the C module source must
be declared as parameter
How do this ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
