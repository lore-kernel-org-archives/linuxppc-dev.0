Message-ID: <67505026E29DD311A9AA00508B7315F31956BA@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Ram Disk
Date: Thu, 24 Aug 2000 12:12:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am running a 7mg ram disk in my 860t. I have multiple programs I start
through linuxrc. I am streaming video, serial data, and running a web server
on various sockets. The webserver is GoAhead. When I click on a cgi script
my system crashes with

Software Emulation Web/62 NIP: 1009a014 *NIP: 0x0 code: ffffffdaSoftware
Emulati
on linuxrc/6 NIP: 1009a014 *NIP: 0x0 code: ffffffdasash-2.03#

Am I running out of ram? I have 16 mgs.

Thanks in advance....
--Julia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
