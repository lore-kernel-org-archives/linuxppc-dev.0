Message-ID: <F9102D41F595D311ACA7009027DE2C840527B186@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: "'Aman'" <aman@mistralsoftware.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cmdline Option in Linux
Date: Mon, 21 Apr 2003 09:49:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What else do you want to specify? The baudrate?

console=/dev/ttyS0,9600

I set this in my bootargs variable for ppcboot...which gets passed in as the bootline and eliminates the need for me to type anything during the boot sequence.

setenv bootargs console=/dev/ttyS0,9600 root=/dev/nfs rw ... ... ...





-----Original Message-----
From: Aman [mailto:aman@mistralsoftware.com]
Sent: Wednesday, April 16, 2003 2:50 PM
To: linuxppc embedded
Subject: Cmdline Option in Linux



Hi All

I have a question relating to the cmdline option ie root=console=dev/null.
When we specify the console=/dev/null how is this implemented. One more
question  is there anyway we can change the cmdline options after the Linux
kernel boots i.e. if I want to specify the console = /dev/ttyS0. Can anybody
help me in understanding this cmdline.

Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
